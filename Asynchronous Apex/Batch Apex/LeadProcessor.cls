public with sharing class LeadProcessor implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc){
		return Database.getQueryLocator([SELECT Id, Name FROM Lead]);
    }
    public void execute(Database.BatchableContext bc, List<Lead> leadList){
        for(Lead lead : leadList){
            lead.LeadSource = 'Dreamforce';
        }
        update leadList;
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Done');
    }
}