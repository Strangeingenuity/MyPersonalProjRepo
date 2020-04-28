/**=====================================================================
* Experian, sm
* Name: LeadWebToHelper
* Description: : Case 00538551 - Send Lead data from ns1 to global instance
* Created Date: 2015-09-07
* Created By: Esteban Castro
* 
* Item #   Date Modified    Modified By          Description of the update
* 
=====================================================================*/
public class LeadWebToHelper {
    
    public static void sendDataToWebToLead(List<Lead> leads){
        
        //leads = [SELECT City,Company,Country,Email,FirstName,Id,LastName,Phone,State FROM Lead WHERE Id = '00Q1b0000015ogr'];
        
        Map<String, String> bodyMap;
        
        for(Lead l : leads){
            bodyMap = new Map<String, String>();
            
            bodyMap.put('oid', '00D20000000lVSR');
            bodyMap.put('retURL', '');
            bodyMap.put('debug', '1');
            if (l.FirstName != null) bodyMap.put('first_name', l.FirstName);
            if (l.LastName != null) bodyMap.put('last_name', l.LastName);
            if (l.Company != null) bodyMap.put('company', l.Company);
            if (l.Email != null) bodyMap.put('email', l.Email);
            if (l.Country != null) bodyMap.put('country', l.Country);
            if (l.State != null) bodyMap.put('state', l.State);
            if (l.City != null) bodyMap.put('city', l.City);
            if (l.Phone != null) bodyMap.put('phone', l.Phone);
            
            // Send data async
            httpSendDataToWebToLead(bodyMap);
        }
        
    }
    
    @future (callout=true)
    public static void httpSendDataToWebToLead(Map<String, String> bodyMap){
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        req.setEndpoint('https://esancaro-dev-ed.my.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8');
        req.setMethod('POST');
        
        req.setCompressed(false);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody(postBodyGenerator(bodyMap));
        
        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
        }
    }
    
    public static void ss(){

        String clientId = '3MVG9WtWSKUDG.x55N8Ip.H6ywNJg_ut3rgZTJmhtfGIhwx99xbsrrlz50eH9WxqA9DZrMlM7EzZ0_g3_GCbX';
        String clientSecret = '5072629425937042648';
        String username= 'esancaro@esancaro.com';
        String password= 'Gl0b4lW4rm1ng';
        
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        req.setEndpoint('https://esancaro-dev-ed.my.salesforce.com/services/oauth2/token');
        
        HttpResponse res = h.send(req);
        
        OAuth2 objAuthenticationInfo = (OAuth2)JSON.deserialize(res.getbody(), OAuth2.class);
        
        System.debug('OAUTH RESULT: ' + objAuthenticationInfo.access_token);
        
        if(objAuthenticationInfo.access_token != null){
            
            Http h1 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setHeader('Authorization','Bearer ' + objAuthenticationInfo.access_token);
            //req1.setHeader('Content-Type','application/json');
            //req1.setHeader('accept','application/json');
            
            //req1.setBody('');//Send JSON body
            req1.setMethod('GET');
            String query = EncodingUtil.urlEncode('SELECT Id, FirstName, LastName, Country, Phone, Email FROM Lead LIMIT 10', 'UTF-8');
            req1.setEndpoint('https://esancaro-dev-ed.my.salesforce.com/services/data/v34.0/query?q=' + query);
            HttpResponse res1 = h1.send(req1);
            System.debug('RESPONSE_BODY: ' + res1.getbody());
            
            //List<Lead> leads = (List<Lead>)JSON.deserialize(res1.getBody(), List<Lead>.class);
            LeadResult lr = (LeadResult)JSON.deserialize(res1.getBody(), LeadResult.class);
            for(Lead l : lr.records){
                System.debug('FUUUUUUUUUUUU: ' + l.Id + ' ' + l.FirstName + ' ' + l.LastName);
            }
        }
    }
    
    // To create the HTTP POST key/value string from a MAP
    public static String postBodyGenerator(Map<String, String> items){
        String ret = '', itm = '';
        
        for(String key : items.keySet()){
            itm = items.get(key);
            ret += key + '=' + itm + '&';
        }
        ret = ret.substring(0, ret.length() - 1);
        
        return ret;
    }
    
    /*To get aouthentication detail Wrapper*/
    public class OAuth2 {
        public String id{get;set;}
        public String issued_at{get;set;}
        public String instance_url{get;set;}
        public String signature{get;set;}
        public String access_token{get;set;}    
    }
 
    public class LeadResult {
        public Integer totalSize{get;set;}
        public Boolean done{get;set;}
        public List<Lead> records{get;set;}
    }
}