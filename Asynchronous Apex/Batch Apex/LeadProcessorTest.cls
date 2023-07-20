@isTest
public class LeadProcessorTest {
    @testSetup private static void setup(){
        List<Lead> leadsToBeInserted = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            leadsToBeInserted.add(new Lead(LastName = 'Test ' + i, Company = 'Test Company ' + i));
        }
        insert leadsToBeInserted;
    }
    
    @isTest private static void testLeadProcessor(){
		Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        
        //performing assertion
        List<Lead> updatedLeads = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'ERROR: At least one lead record not updated correctly.');
    }
}