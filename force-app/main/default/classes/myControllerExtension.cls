public class myControllerExtension {

    Public final Account accnt;

    public myControllerExtension(ApexPages.StandardController Stdcontroller) {
            
            this.accnt = (Account)Stdcontroller.getRecord();
            
            }
            
    Public String getgreeting(){
    
            
    return ('this is the account '+ accnt.id);
    }

   

}