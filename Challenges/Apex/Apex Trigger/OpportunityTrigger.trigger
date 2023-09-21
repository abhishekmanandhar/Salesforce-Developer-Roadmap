trigger OpportunityTrigger on Opportunity (before insert) {
    if(Trigger.IsInsert){
        if(Trigger.IsBefore){
            OpportunityTriggerHandler.updateDescOnInsert(Trigger.New);
        }
        if(Trigger.IsAfter){
            OpportunityTriggerHandler.updateLatestOpportunityAmountFieldOnAccount(Trigger.New);
        }
    }
}