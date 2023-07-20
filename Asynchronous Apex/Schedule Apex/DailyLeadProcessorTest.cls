@isTest
public with sharing class DailyLeadProcessorTest {

    //CRON Expression for midnight
    private static String CRON_EXP = '0 0 0 ? * * *';

    @testSetup private static void setup(){
        //insert 200 Lead records
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200; i++){
            leads.add(new Lead(LastName='Test'+i, Company='Test'+i));
        }
        insert leads;
    }

    @isTest
    private static void test(){
        //schedule the DailyLeadProcessor class to run and test that all Lead records were updated correctly
        Test.startTest();
        String jobId = System.schedule('DailyLeadProcessor', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();

        //assert results
        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}