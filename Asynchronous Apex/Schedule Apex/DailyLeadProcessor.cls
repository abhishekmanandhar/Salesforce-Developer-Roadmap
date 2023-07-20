public with sharing class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext sc) {
        List<Lead> leadsToBeUpdated = new List<Lead>();
        //find the first 200 Lead records with a blank LeadSource field and update them with the LeadSource value of Dreamforce
        for(Lead l : [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200]) {
            l.LeadSource = 'Dreamforce';
            leadsToBeUpdated.add(l);
        }
        //update the Leads records
        update leadsToBeUpdated;
    }
}