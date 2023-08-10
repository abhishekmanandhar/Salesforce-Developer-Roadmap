public with sharing class ApexCodingChallenges {
    public static void scenarioOne(){
        List<Opportunity> oppToInsert = new List<Opportunity>();
        for( Account acc : [SELECT Id, Name FROM Account WHERE CreatedDate = LAST_90_DAYS]){
            oppToInsert.add(new Opportunity(Name = acc.Name + ' Opportunity', CloseDate = System.today() + 7, StageName = 'Prospecting', AccountId = acc.Id));
        }
        if(!oppToInsert.isEmpty()){
			Database.insert(oppToInsert, true);
        }
    }
    
    public static void scenarioTwo(){
        List<Account> accToUpdate = new List<Account>();
        for(Account acc : [SELECT Id, Phone FROM Account WHERE CreatedDate = LAST_90_DAYS]){
            acc.Phone = '1234567890';
            accToUpdate.add(acc);
        }
        if(!accToUpdate.isEmpty()){
            Database.update(accToUpdate);
        }
    }
    
    public static void scenarioThree(){
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        for(Opportunity opp : [SELECT Id, StageName, Description FROM Opportunity WHERE CreatedDate = LAST_90_DAYS]){
            if(opp.StageName == 'Closed Won'){
                opp.Description = 'Opportunity is Closed Won';
            } else if(opp.StageName == 'Closed Lost'){
                opp.Description = 'Opportunity is Closed Lost';
            }
            oppToUpdate.add(opp);
        }
        if(oppToUpdate.size() > 0){
            Database.update(oppToUpdate);
        }
    }
    
    public static void scenarioFour(){
        Integer count = 0;
        List<Account> accToUpdate = new List<Account>();
        for(Account acc : [SELECT Id, Total_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE CreatedDate = LAST_90_DAYS]){
            count = 0;
            for(Contact con : acc.Contacts){
                count++;
            }
            acc.Total_Contacts__c = count;
            accToUpdate.add(acc);
        }
        if(!accToUpdate.isEmpty()){
            Database.update(accToUpdate);
        }
    }
}