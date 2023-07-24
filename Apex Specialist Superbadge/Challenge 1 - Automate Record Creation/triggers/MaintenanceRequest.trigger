trigger MaintenanceRequest on Case (before update, after update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        MaintenanceRequestHelper.newMaintenanceRequest(Trigger.new, Trigger.oldMap);
    }
}