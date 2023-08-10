public with sharing class ApexCodingChallenges {
    //Query Account records created in last 90 days. Now Insert one opportunity record for each account.
    public static void scenarioOne(){
        List<Opportunity> oppToInsert = new List<Opportunity>();
        for( Account acc : [SELECT Id, Name FROM Account WHERE CreatedDate = LAST_90_DAYS]){
            oppToInsert.add(new Opportunity(Name = acc.Name + ' Opportunity', CloseDate = System.today() + 7, StageName = 'Prospecting', AccountId = acc.Id));
        }
        if(!oppToInsert.isEmpty()){
			Database.insert(oppToInsert, true);
        }
    }
    
    //Query Account records created in last 90 days. Now update phone number of all accounts with '1234567890' value.
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
    
    //Query Opportunity records created in last 90 days. Now update description of all opportunities with 'Opportunity is Closed Won' if stage is 'Closed Won' and 'Opportunity is Closed Lost' if stage is 'Closed Lost'.
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
    
    //Query Account records created in last 90 days. Now update Total_Contacts__c field of all accounts with count of contacts associated with that account.
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

    //Query Contact records created in last 90 days. Now update phone number of all contacts with phone number of associated account if the contacts phone is empty.
    public static void scenarioFive(){
        List<Contact> conToUpdate = new List<Contact>();
        for(Contact con : [SELECT Id, Phone, Account.Phone FROM Contact WHERE CreatedDate = LAST_90_DAYS]){
            if(con.Phone == null){
                con.Phone = con.Account.Phone;
                conToUpdate.add(con);
            }
        }
        if(!conToUpdate.isEmpty()){
            Database.update(conToUpdate);
        }
    }
}