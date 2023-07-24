@isTest
public with sharing class MaintenanceRequestHelperTest {
    private static Vehicle__c createVehicle(){
        Vehicle__c vehicle = new Vehicle__c(Name = 'Ferrari');
        return vehicle;
    }

    private static Product2 createEquipment(){
        Product2 equipment = new Product2(Name = 'Ferrari Equipment', Lifespan_Months__c = 10, Maintenance_Cycle__c = 10, Replacement_Part__c = true);
        return equipment;
    }

    private static Case createMaintenanceRequest(Id vehicleId, Id equipmentId){
        Case cc = new Case(Type = 'Repair', Status = 'New', Origin = 'Web', Subject = 'Subject Test', Equipment__c = equipmentId, Vehicle__c = vehicleId);
        return cc;
    }

    private static Equipment_Maintenance_Item__c createEMI(Id equipmentId, Id maintenanceRequestId){
        Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(Equipment__c = equipmentId, Maintenance_Request__c = maintenanceRequestId);
        return emi;
    }

    @isTest private static void testNewMaintenanceRequestPositive(){
        //test data setup
        Vehicle__c vehicle = createVehicle();
        insert vehicle;
        Id vehicleId = vehicle.Id;

        Product2 equipment = createEquipment();
        insert equipment;
        Id equipmentId = equipment.Id;

        Case maintenanceRequest = createMaintenanceRequest(vehicleId, equipmentId);
        insert maintenanceRequest;

        Equipment_Maintenance_Item__c emi = createEMI(equipmentId, maintenanceRequest.Id);
        insert emi;

        //performing test
        Test.startTest();
        maintenanceRequest.Status = 'Closed';
        update maintenanceRequest;
        Test.stopTest();

        //asserting results
        Case newMaintenanceRequest = [SELECT Id, Subject, Type, Equipment__c, Date_Reported__c, Vehicle__c, Date_Due__c FROM case WHERE Status = 'New'];

        Equipment_Maintenance_Item__c newEMI = [SELECT Id FROM Equipment_Maintenance_Item__c WHERE Maintenance_Request__c = :newMaintenanceRequest.Id];

        System.assert(newEMI != null);
        System.assert(newMaintenanceRequest.Subject != null);
        System.assertEquals(newMaintenanceRequest.Type, 'Routine Maintenance');
        System.assertEquals(newMaintenanceRequest.Equipment__c, equipmentId);
        System.assertEquals(newMaintenanceRequest.Vehicle__c, vehicleId);
        System.assertEquals(newMaintenanceRequest.Date_Reported__c, System.today());
    }

    @istest private static void testNewMaintenanceRequestNegative(){
        //test data setup
        Vehicle__C vehicle = createVehicle();
        insert vehicle;
        id vehicleId = vehicle.Id;
        
        product2 equipment = createEquipment();
        insert equipment;
        id equipmentId = equipment.Id;
        
        Case maintenanceRequest = createMaintenanceRequest(vehicleId, equipmentId);
        insert maintenanceRequest;

        Equipment_Maintenance_Item__c emi = createEMI(equipmentId, maintenanceRequest.Id);
        insert emi;
        
        //performing test
        test.startTest();
        maintenanceRequest.Status = 'Working';
        update maintenanceRequest;
        test.stopTest();
        
        //asserting results
        List<Case> newMaintenanceRequest = [SELECT Id FROM Case];
        
        Equipment_Maintenance_Item__c newEMI = [SELECT Id FROM Equipment_Maintenance_Item__c WHERE Maintenance_Request__c = :maintenanceRequest.Id];
        
        System.assert(newEMI != null);
        System.assert(newMaintenanceRequest.size() == 1);
    }
    
    @istest private static void testMaintenanceRequestBulk(){
        //test data setup
        list<Vehicle__C> vehicleList = new list<Vehicle__C>();
        list<Product2> equipmentList = new list<Product2>();
        list<Equipment_Maintenance_Item__c> emiList = new list<Equipment_Maintenance_Item__c>();
        list<case> requestList = new list<case>();
        
        for(integer i = 0; i < 300; i++){
           vehicleList.add(createVehicle());
            equipmentList.add(createEquipment());
        }
        insert vehicleList;
        insert equipmentList;
        
        for(integer i = 0; i < 300; i++){
            requestList.add(createMaintenanceRequest(vehicleList.get(i).Id, equipmentList.get(i).Id));
        }
        insert requestList;
        
        for(integer i = 0; i < 300; i++){
            emiList.add(createEMI(equipmentList.get(i).ID, requestList.get(i).Id));
        }
        insert emiList;
        
        //performing test
        Test.startTest();
        for(Case req : requestList){
            req.Status = 'Closed';
        }
        update requestList;
        Test.stopTest();
        
        //asserting results
        list<Case> newMaintenanceRequest = [SELECT Id FROM Case WHERE Status = 'New'];
        
        system.assert(newMaintenanceRequest.size() == 300);
    }
}