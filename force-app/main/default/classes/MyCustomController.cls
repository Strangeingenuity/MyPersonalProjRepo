Public Class MyCustomController {

    //Public MyCustomController() {}
          Public Contact Con{get;set;}   
    
            public PageReference save() {
                    Insert Con;
                    return null;
            }
       /* public String getName() {
            return 'MyController';
        }*/
    
        /*public Contact getcon() {
            if(Con == null) 
                con = [select id, Firstname, LastName from Contact 
                           where id = :ApexPages.currentPage().getParameters().get('id')];
            return con; 
        } */
                        
          /*          
          //@RemoteAction
           Public String CreateContact(string FirstName, string LastName){
                    Contact C= new Contact (Firstname= Firstname, LastName= LastName);
                    insert c;
                    return c.Id; */
      

}