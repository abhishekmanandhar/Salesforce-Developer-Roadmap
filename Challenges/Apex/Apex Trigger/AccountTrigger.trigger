trigger AccountTrigger on Account (before insert, after insert) {
    if(Trigger.IsInsert){
        if(Trigger.IsBefore){
            //Before insert: If Account Industry is not null and having value as 'Media' then populate Rating as Hot.
            AccountTriggerHandler.accountRatingHot(Trigger.New);
        }
        if(Trigger.IsAfter){
            //After insert: Create related Opportunity when the account is created.
            AccountTriggerHandler.createRelatedOpp(Trigger.New);
        }
    }
}