public with sharing class NewExistingRecord {
    
    public Account account {get; set;}

    Public NewExistingRecord(){
    
    Id id =  Apexpages.currentpage().getparameters().get('Id');
    account = (Id ==Null)? New Account(): [select Name, Phone, Industry from Account where Id = :id];
    
    
    
    }



    public String getAccounts() {
        return null;
    }

}