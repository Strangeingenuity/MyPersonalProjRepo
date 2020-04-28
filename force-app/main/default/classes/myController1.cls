public class myController1 {

    private final Account accnt;
    
    Public MyController1() {
        accnt = [SELECT Id, Name, Site FROM Account 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
    
    Public Account getAccnt(){
                return accnt ;

    } 
   
   Public PageReference Save(){
           update accnt;
           return null;
   
   
   
   }
   
    
}