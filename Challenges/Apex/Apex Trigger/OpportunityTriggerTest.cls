@isTest
public class OpportunityTriggerTest {
    @isTest public static void testupdateDescOnInsert(){
        
        //Test data setup
        List<Opportunity> oppToInsert = new List<Opportunity>();
        
        for(Integer i = 0; i < 200; i++){
            Opportunity opp = new Opportunity(Name = 'Opportunity ' + i, CloseDate = System.today() + 5, StageName = 'Prospecting', Amount = 120000);
            oppToInsert.add(opp);
        }
        
        //Testing logic
        Test.startTest();
        Database.insert(oppToInsert);
        Test.stopTest();
        
        //Assertion
        List<Opportunity> insertedOpp = [SELECT Id, Description FROM Opportunity WHERE Id = :oppToInsert[0].Id];
        System.assertEquals('Hot Opportunity', insertedOpp[0].Description, 'The description is not changed to Hot Opportunity');
    }

    @isTest
    public static void Test_UpdateLatestOpportunityAmountFieldOnAccount(){
        //create test data
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 200; i++){
            accList.add(new Account(Name = 'Test ' + i, Industry = 'Banking'));
        }
        if(!accList.isEmpty()){
            insert accList;
        }
        
        List<Opportunity> oppToCreateOnAccount = new List<Opportunity>();
        for(Account acc : accList){
            oppToCreateOnAccount.add(new Opportunity(Name = acc.Name, CloseDate = System.today() + 5, StageName = 'Prospecting', AccountId = acc.Id, Amount = 200000));
        }
        
        //Test logic
        Test.startTest();
        insert oppToCreateOnAccount;
        Test.stopTest();

        //Assertion
        List<Account> updatedAcc = [SELECT Id, Latest_Opportunity_Amount__c FROM Account WHERE Id = :accList[0].Id];
        List<Opportunity> createdOpp = [SELECT Id, Amount FROM Opportunity WHERE Id = :oppToCreateOnAccount[0].Id];
        
        System.assertEquals(createdOpp[0].Amount, updatedAcc[0].Latest_Opportunity_Amount__c, 'The Amounts are not equal');
    }
}