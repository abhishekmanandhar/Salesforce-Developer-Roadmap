@isTest
public class AccountProcessorTest {
	@isTest
    private static void countContactsTest(){
		
        //create test data
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 300; i++){
            accList.add(new Account(Name = 'Test ' + i));
        }
        
        insert accList;
        
        List<Contact> conList = new List<Contact>();
        List<Id> accIds = new List<Id>();
        for(Account acc : accList){
            conList.add(new Contact(LastName = acc.Name, AccountId = acc.Id));
            accIds.add(acc.Id);
        }
        
        insert conList;
        
        //call method under test
        Test.startTest();
        AccountProcessor.countContacts(accIds);
        Test.stopTest();
        
        //perform assertions
        List<Account> accounts = [SELECT Id, Number_Of_Contacts__c FROM Account];
        
        System.assertEquals(1, accounts[0].Number_Of_Contacts__c);
    }
}