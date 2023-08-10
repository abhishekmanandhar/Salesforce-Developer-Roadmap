public class AccountTriggerHandler {
    public static void accountRatingHot(List<Account> accList){
        for(Account acc : accList){
            if(acc.Industry != null && acc.Industry == 'Media'){
                acc.Rating = 'Hot';
            }
        }
    }
    
    public static void createRelatedOpp(List<Account> accList){
        List<Opportunity> oppToCreate = new List<Opportunity>();
        for(Account acc : accList){
            Opportunity opp = new Opportunity(Name = acc.Name + ' Opportunity', CloseDate = System.today() + 5, StageName = 'Prospecting', AccountId = acc.Id);
            oppToCreate.add(opp);
        }
        if(!oppToCreate.isEmpty()){
            Database.insert(oppToCreate);
        }
    }
}