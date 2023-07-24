public with sharing class MaintenanceRequestHelper {
    public static void newMaintenanceRequest(List<Case> updatedCases, Map<Id, Case> unUpdatedCases){
        // Find Maintenance Request,
        // Type = Repair or Routine Maintenance AND Status = Closed
        Set<Id> caseIds = new Set<Id>();
        for(Case c : updatedCases){
            if(unUpdatedCases.get(c.Id).Status != 'Closed' && c.Status == 'Closed'){
                if(c.Type == 'Repair' || c.Type == 'Routine Maintenance'){
                    caseIds.add(c.Id);
                }
            }
        }
        
        if(!caseIds.isEmpty()){
            List<Case> newCases = new List<Case>();
            
            //Get the closed Cases details
            Map<Id, Case> closedCases = new Map<Id, Case>([SELECT Id, Equipment__c, Vehicle__c, Equipment__r.Maintenance_Cycle__c, (SELECT Id, Equipment__c, Quantity__c FROM Equipment_Maintenance_Items__r) FROM Case WHERE Id IN :caseIds]);

            //calculate Maintenance Cycles of all the Equiments associated with the vehicle
            Map<Id, Decimal> maintenanceCycles = new Map<Id, Decimal>();
            AggregateResult[] results = [SELECT Maintenance_Request__c, MIN(Equipment__r.Maintenance_Cycle__c) cycle
                                         FROM Equipment_Maintenance_Item__c
                                         WHERE Maintenance_Request__c IN :caseIds
                                         GROUP BY Maintenance_Request__c];

            for (AggregateResult ar : results){ 
                maintenanceCycles.put((Id) ar.get('Maintenance_Request__c'), (Decimal) ar.get('cycle'));
            }
            
            // Create new Maintenance Request
            for(Case c : closedCases.values()){
                Case nc = new Case (
                    ParentId = c.Id,
                    Status = 'New',
                    Subject = 'Routine Maintenance',
                    Type = 'Routine Maintenance',
                    Vehicle__c = c.Vehicle__c,
                    Equipment__c =c.Equipment__c,
                    Origin = 'Web',
                    Date_Reported__c = Date.Today()
                );
                
                //shortest due date based on maintenance cycle of equipment
                If (maintenanceCycles.containskey(c.Id)){
                    nc.Date_Due__c = Date.today().addDays((Integer) maintenanceCycles.get(c.Id));
                } else {
                    nc.Date_Due__c = Date.today().addDays((Integer) c.Equipment__r.maintenance_Cycle__c);
                }
                
                newCases.add(nc);
            }
            
            insert newCases;
            
            // Clone the Equipment Maintenance Item to new Cases
            List<Equipment_Maintenance_Item__c> clonedEMI = new List<Equipment_Maintenance_Item__c>();
            for (Case nc : newCases){
                    for (Equipment_Maintenance_Item__c emi : closedCases.get(nc.ParentId).Equipment_Maintenance_Items__r){
                        Equipment_Maintenance_Item__c emiClone = emi.clone();
                        emiClone.Maintenance_Request__c = nc.Id;
                        clonedEMI.add(emiClone);
                    }
                }
            insert clonedEMI;
        }
    }
}