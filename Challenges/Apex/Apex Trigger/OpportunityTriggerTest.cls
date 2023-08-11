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
}