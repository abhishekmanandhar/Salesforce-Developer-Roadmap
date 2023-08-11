trigger ContactTrigger on Contact (before insert) {
    if(Trigger.IsInsert){
        if(Trigger.IsBefore){
            ContactTriggerHandler.sendEmailOnContactInsert(Trigger.New);
        }
    }
}