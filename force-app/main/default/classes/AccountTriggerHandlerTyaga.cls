Public Without Sharing Class AccountTriggerHandlerTyaga {

   
    Public Static Void afterUpdate (List<Account> NewAcc, Map<Id,Account> OldMap){
        //List<Account> NewAcc1 = New List<Account>();
        //Map<Id,Account> Oldmap1 = New Map<Id,Account> ();
        //Oldmap1 = OldMap;
        String CountryCd;
        system.debug('Tyaga I am here 0000');
        List<Account> AccTbd = New List<Account>();
        for (Account acc : NewAcc) {
            if (OldMap!= null && Oldmap.get(acc.Id).SourceForWsCall__c != acc.SourceForWsCall__c)
                { 
                AccTbd.add(acc);
                
                }
           else
               {
                    Continue; 
               }
         }//End of For
    
    if(AccTbd.size() > 0)
        {
         system.debug('Tyaga I am here before the webservice call');
         String IP = AccTbd[0].SourceForWsCall__c ;
         WebserviceCall(IP,countryCd);
         //AccTbd[0].WebSerField__c= CountryCd;
         //System.debug('So the address of the country is' + Registeradd);
         system.debug('Tyaga I am here after the web service call'+countryCd);
        }
    
    }//end of after Update function

    //Webservice Call Function
   @Future(callout=true)
   Public static Void WebserviceCall(String IP, string CountryCd){ 
         wwwWebservicexNet.GeoIPServiceSoap MyTestStub = new wwwWebservicexNet.GeoIPServiceSoap();
         wwwWebservicexNet.GeoIP Responce = new wwwWebservicexNet.GeoIP();
         //String IP = AccTbd[0].SourceForWsCall__c ;
         Responce = MyTestStub.GetGeoIP(IP);
         CountryCd =  Responce.CountryCode;
         system.debug('This is the Country Code'+Responce.CountryCode);
         //System.debug('So the address of the country is' + Registeradd);
         //This below statement will never run because, there will be no return from a @future web service call
         system.debug('Tyaga I am here inside the webservice call '+CountryCd);
         return;
    }
    
    
    
    
    //docSample.DocSamplePort stub = new docSample.DocSamplePort();
    //stub.inputHttpHeaders_x = new Map<String, String>();




/*
//Setting a basic authentication header

stub.inputHttpHeaders_x.put('Authorization', 'Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==');

//Setting a cookie header
stub.inputHttpHeaders_x.put('Cookie', 'name=value');

//Setting a custom HTTP header
stub.inputHttpHeaders_x.put('myHeader', 'myValue');

String input = 'This is the input string';
String output = stub.EchoString(input);
*/    
  

}//end of Class