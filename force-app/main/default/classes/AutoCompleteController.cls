public with sharing class AutoCompleteController {

    public String gettestStr1() {
        return testStr;
    }

        Public List<SelectOption> RatingOptions{get;set;}
        //Start of Constructer Code
        public Account accounts {get; set;}
        private string testStr = 'test';
        Public AutoCompleteController(){
            System.debug('--Constructor called--');                     
            initPicklists();
            system.debug('hi Tyaga :::My Rating PickList has the following values.'+RatingOptions);
        }
        
       
        
        Public Void initPicklists()
        {
           try{
           RatingOptions = new List<SelectOption>();
           //RatingOptions.add(new SelectOption('', 'test'));
           Account Acnt = new Account();
           string Rate = Acnt.Rating;
          

           Schema.DescribeFieldResult fieldResult = Account.Rating.getDescribe();
           List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
               for (Schema.PicklistEntry a: ple )
                      { 
                     RatingOptions.add(new SelectOption(a.getLabel(), a.getValue())); 
                      }
                   }
               catch(exception e)
                   {
                   system.debug(e.getMessage());
                   }   
        }

}

/*          // for (SelectOption picklistValue:DescribeUtility.getPicklistValues(Acnt, 'Rating')) 
          //        RatingOptions.add(picklistValue);
          
           /*Schema.sObjectType objType = Acnt.getSObjectType();        
           Schema.DescribeSObjectResult objDescribe = objType.getDescribe();       
           map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap(); 
           list<Schema.PicklistEntry> values = fieldMap.get().getDescribe().getPickListValues();   */