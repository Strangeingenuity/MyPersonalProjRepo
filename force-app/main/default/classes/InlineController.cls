public class InlineController {
    public InlineController(ApexPages.StandardController controller) {
    }
   public Contact newContact { get; set; }
    public Contact editContact { get; set; }
    public InlineController () {
       newContact = new Contact();
    } 
    public Contact[] getEmployees() {
        return [Select c.MailingCountry, c.LastName, c.Id, c.Email From Contact c];
    }
    public String getParam(String name) {
        return ApexPages.currentPage().getParameters().get(name);  
    }
    public PageReference del() {
        try {
            String delid = getParam('delid');
            Contact employee = [SELECT Id FROM Contact WHERE ID=:delid];
            DELETE employee;
        } catch (Exception e) {
            ApexPages.addMessages(e);
        }
        return null;
    }
    public PageReference editcon() {
        String editid = getParam('editid');
        editContact = [SELECT Name, LastName, email,MailingCountry FROM Contact WHERE id=:editid];
        return null;
    }
    public PageReference cancelEdit() {
   // System.Debug('GETURL ::: '+ApexPages.currentPage().getUrl());
        editContact = null;
        return null;
    }
    public PageReference saveEdit() {
        try {
            UPDATE editContact;
            editContact = null;
        } catch (Exception e) {
            ApexPages.addMessages(e);
        }
        return null;
   }
}