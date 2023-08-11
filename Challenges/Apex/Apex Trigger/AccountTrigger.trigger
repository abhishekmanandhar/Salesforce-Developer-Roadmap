trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete) {
    if(Trigger.IsInsert){
        if(Trigger.IsBefore){
            //AccountTriggerHandler.accountRatingHot(Trigger.New);
            AccountTriggerHandler.updateRating(Trigger.New);
        }
        if(Trigger.IsAfter){
            AccountTriggerHandler.createRelatedOpp(Trigger.New);
        }
    }
    
    if(Trigger.IsUpdate){
        if(Trigger.IsBefore){
            AccountTriggerHandler.updateAccountDesc(Trigger.New, Trigger.oldMap);
        }
        if(Trigger.IsAfter){
			AccountTriggerHandler.udpatePhoneofOpps(Trigger.New, Trigger.oldMap);
        }
    }
}