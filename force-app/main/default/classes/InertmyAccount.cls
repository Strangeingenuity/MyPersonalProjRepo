Public Class InertmyAccount {

    //Public MyCustomController() {}
           Contact Con{get;set;}   
    
            public PageReference save() {
                    Insert Con;
                    PageReference pg = new PageReference('/'+Con.Id) ;
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