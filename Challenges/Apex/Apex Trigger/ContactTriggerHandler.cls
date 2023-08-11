public class ContactTriggerHandler {
    public static void sendEmailOnContactInsert(List<Contact> newConList){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(Contact con : newConList){
            if(con.Email != null){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                //public Void setToAddresses(String[] toAddresses)
                String[] toAddress = new String[]{con.Email};
                email.setToAddresses(toAddress);
                String emailSubject = 'Welcome ' + con.FirstName;
                email.setSubject(emailSubject);
                String displayName = 'Abhishek Manandhar';
                email.setSenderDisplayName(displayName);
                String content = 	'Hi! ' + con.FirstName + '<br/><br/>' +
                    				'Welcome to Salesforce. I hope you will have at good time learning Salesforce.<br/><br/>' +
                    				'Thank You!<br/>' +
                    				'Abhishek Manandhar';
                email.setHtmlBody(content);
                emails.add(email);
            }
            Messaging.sendEmail(emails);
        }
    }
}