public with sharing class CaseListController_lightning {


    @AuraEnabled
    public static List<caseWrapper> findAll(String orderBy, String order) {
        List<caseWrapper> caseList = new List<caseWrapper>();
        try {
            String query = 'SELECT id, CaseNumber, Subject, Status, CreatedDate, LastModifiedDate FROM Case Order By '
                        + orderBy + ' ' + order + ' LIMIT 50000';
            caseList = convertDates(Database.query(query));
        }
        catch (exception e) {
            throw new AuraHandledException('Some exception happened on server side controller with the following error:\n\n'+ e.getMessage());
        }
        return caseList;
       
    }

    @AuraEnabled
    public static Case findById(String caseNo) {
        return [SELECT id, CaseNumber, Subject, Status, CreatedDate, LastModifiedDate, LastModifiedBy.Name
                    FROM Case WHERE CaseNumber = :caseNo Limit 1];
    }

    @AuraEnabled
    public static List<Case> findBySearch(String searchKey, String searchType, String orderBy, String order) {

        List<Case> caseList = new List<Case>();

        try {
            String searchCriteria;
            if(searchType == 'CaseNumber'){
                searchCriteria = searchType +' =' + '\'' + searchKey + '\'';
            }else{
                searchCriteria = searchType +' Like \'%' + searchKey + '%\'';
            }
            
            String query = '';
            if(searchKey == ''){
                query = 'SELECT id, CaseNumber, Subject, Status, CreatedDate, LastModifiedDate FROM Case Order By ' + orderBy + ' ' + order + ' Limit 50' ;
            }else{
                query = 'SELECT id, CaseNumber, Subject, Status, CreatedDate, LastModifiedDate FROM Case WHERE ' + searchCriteria + ' Order By ' + orderBy + ' ' + order ;
            }
            system.debug(query);
            caseList = Database.query(query);

        }
        catch (exception e) {
            throw new AuraHandledException('Some exception happened on server side controller with the following error:\n\n'+ e.getMessage());
        }

        return caseList;
    }

    public static List<caseWrapper> convertDates(List<Case> caseList){
        TimeZone userTimezone = UserInfo.getTimeZone();
        List<caseWrapper> caseWrapperList = new List<caseWrapper>();
        for(case c:caseList){
            caseWrapper cw = new caseWrapper();
            cw.Id = c.Id;
            cw.CaseNumber = c.CaseNumber;
            cw.Subject = c.Subject;
            cw.Status = c.Status;
            cw.CreatedDate = c.CreatedDate.format('yyyy-MM-dd hh:mm:ss', userTimezone.getID());
            cw.LastModifiedDate = c.LastModifiedDate.format('yyyy-MM-dd hh:mm:ss', userTimezone.getID());
            caseWrapperList.add(cw);   
        }
        return caseWrapperList;
    }

    /****Wrapper Classes***/
    public class caseWrapper{
        @AuraEnabled
        public String Id {get; set;}
        @AuraEnabled
        public String CaseNumber {get; set;}
        @AuraEnabled
        public String Subject {get; set;}
        @AuraEnabled
        public String Status {get; set;}
        @AuraEnabled
        public String CreatedDate {get; set;}
        @AuraEnabled
        public String LastModifiedDate {get; set;}
        
        public caseWrapper(){

        }
    }


}