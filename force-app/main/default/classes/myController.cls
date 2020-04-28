public class myController {

    private final Account accnt;
    
    Public MyController() {
        accnt = [SELECT Id, Name, Site FROM Account 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
    
    Public Account getAccount(){
                return accnt ;

    } 
   
   Public PageReference Save(){
           update accnt;
           return null;
   
   
   
   }
   
    
}