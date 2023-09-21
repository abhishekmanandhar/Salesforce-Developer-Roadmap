public class OpportunityTriggerHandler {
    public static void updateDescOnInsert(List<Opportunity> newOppList){
        for(Opportunity opp : newOppList){
            if(opp.Amount >= 100000 && opp.Amount <= 500000){
                opp.Description = 'Hot Opportunity';
            }
        }
    }

    public static void updateLatestOpportunityAmountFieldOnAccount(List<Opportunity> newOppList){
        List<Account> accList = new List<Account>();
        for(Opportunity opp : newOppList){
            if(opp.Amount != null && opp.AccountId != null){
                accList.add(new Account(Latest_Opportunity_Amount__c = opp.Amount, Id = opp.AccountId));
            }
        }
        
        if(!accList.isEmpty()){
            update accList;
        }
    }
}