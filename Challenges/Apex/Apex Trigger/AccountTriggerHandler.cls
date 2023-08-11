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
    
    public static void updateAccountDesc(List<Account> newAccList, Map<Id, Account> oldAccMap){
        for(Account acc : newAccList){
            if(oldAccMap != null && acc.Phone != oldAccMap.get(acc.Id).Phone){
                acc.Description = 'Account Phone has been updated!';
            }
        }
    }
    
    public static void udpatePhoneofOpps(List<Account> newAccList, Map<Id, Account> oldAccMap){
        Map<Id, Account> accWithUpdatedPhone = new Map<Id, Account>();
        for(Account acc : newAccList){
            if(oldAccMap != null && acc.Phone != oldAccMap.get(acc.Id).Phone){
                accWithUpdatedPhone.put(acc.Id, acc);
            }
        }
        
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        for(Opportunity opp : [SELECT Id, Phone__c, AccountId FROM Opportunity WHERE AccountId IN :accWithUpdatedPhone.keySet()]){
            if(accWithUpdatedPhone.containsKey(opp.AccountId)){
                opp.Phone__c = accWithUpdatedPhone.get(opp.AccountId).Phone;
            	oppToUpdate.add(opp);
            }
        }
        
        if(!oppToUpdate.isEmpty()){
            Database.update(oppToUpdate);
        }
    }
}