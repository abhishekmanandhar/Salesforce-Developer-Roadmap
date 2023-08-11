public class OpportunityTriggerHandler {
    public static void updateDescOnInsert(List<Opportunity> newOppList){
        for(Opportunity opp : newOppList){
            if(opp.Amount >= 100000 && opp.Amount <= 500000){
                opp.Description = 'Hot Opportunity';
            }
        }
    }
}