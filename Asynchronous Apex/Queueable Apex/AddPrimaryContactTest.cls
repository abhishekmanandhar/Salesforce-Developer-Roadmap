@isTest
public class AddPrimaryContactTest {
    @testSetup private static void setup(){
        List<Account> accToBeInserted = new List<Account>();
        
        for(Integer i = 0; i < 100; i++){
            if(i<50){
                accToBeInserted.add(new Account(Name = 'Test Account ' + i, BillingState = 'NY'));
            } else {
                accToBeInserted.add(new Account(Name = 'Test Account ' + i, BillingState = 'CA'));
            }
        }
        insert accToBeInserted;
    }
    
    @isTest private static void test(){
        Contact contact = new Contact(FirstName = 'Abhishek', LastName = 'Manandhar');
        insert contact;
        
        Test.startTest();
        Id jobId = System.enqueueJob(new AddPrimaryContact(contact, 'CA'));
        Test.stopTest();
        
		List<Contact> conList = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'];
        System.assertEquals(50, conList.size());
    }
}