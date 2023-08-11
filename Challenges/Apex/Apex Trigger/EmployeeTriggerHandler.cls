public class EmployeeTriggerHandler {
    public static void preventDeleteOnNotAcitve(List<Employee__c> oldEmpList){
        for(Employee__c emp : oldEmpList){
            if(emp.Active__c == true){
                emp.addError('Sorry! You cannot delete Employee accounts who are still active.');
            }
        }
    }
}