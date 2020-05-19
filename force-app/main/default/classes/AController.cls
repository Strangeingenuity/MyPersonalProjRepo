public class AController {

public PageReference redirec() {
// It seems that Edit event provide the working Opportunity id with newid

// testing if the date changes on the server 
id oppId = ApexPages.currentPage().getParameters().get('newid');
// If no parameter, stay there (for debug)
if(oppId == null) return null;

// If Opportunity is not found (no way...), try to go to the detail page
// YOU NEED TO PUT SOME LOGIC TO DETERMINE WHERE TO REDIRECT TO
PageReference pageDetail = new PageReference ('/'+oppId);
pageDetail.setRedirect(true);
Opportunity[] oppList = [select id, Name, AccountId from Opportunity where id = :oppId];
if(oppList.size() == 0) return pageDetail;

// Go to the account page
PageReference pageAccount = new PageReference('/'+oppList[0].AccountId);
pageAccount.setRedirect(true);
return pageAccount; 
}
}