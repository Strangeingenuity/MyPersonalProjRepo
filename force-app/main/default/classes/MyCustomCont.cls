public class MyCustomCont {
    public Account accounts { get; set; }
    
    Public MyCustomCont (){
           Id id = Apexpages.currentpage().getparameters().get('id'); 
           accounts = (id == Null)? New Account(): [Select Name, Phone, Industry from Account where Id = :id];
           
           }

    Public Pagereference save(){
        try{
            upsert (accounts);
            }
        catch(System.DMLException e)
            {
            ApexPages.addmessages(e);
            return null;
            }    

      return (new ApexPages.StandardController(accounts)).view();

    }
}