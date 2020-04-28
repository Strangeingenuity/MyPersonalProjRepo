//This is the code from the training to show how to create a dynamic url and do a page redirect.
//this is being called from the visual force page PositionApplicationForm which is part of the custom link on the home page.


public class posAppFormRedirect_Controller {
    public PageReference doRedirect() {
        String apiUrl = [select id, User_API_URL__c from User where Id = :UserInfo.getUserId()].User_API_URL__c;
        return new PageReference('https://candidateobm.herokuapp.com/email?sid='+UserInfo.getSessionId() + '&url=' + apiUrl + '&uname=' + UserInfo.getUserName());
    }
}