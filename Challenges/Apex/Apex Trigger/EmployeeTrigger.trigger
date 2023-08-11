trigger EmployeeTrigger on Employee__c (before delete) {
	if(Trigger.IsDelete){
        if(Trigger.IsBefore){
            EmployeeTriggerHandler.preventDeleteOnNotAcitve(Trigger.Old);
        }
    }
}