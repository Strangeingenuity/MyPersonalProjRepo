public class NewEditRec {

    public Account accounts { get; set; }
    
    Public NewEditRec(){
           Id id = Apexpages.currentpage().getparameters().get('id'); 
           accounts = (id == Null)? New Account(): [Select Name, Phone, Industry from Account where Id = :id];
           
           }
            

    Public Pagereference save(){
            upsert (accounts);
            return null;

    }



}