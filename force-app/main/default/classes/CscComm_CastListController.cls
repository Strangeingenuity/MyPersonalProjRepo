public with sharing class CscComm_CastListController {
  @AuraEnabled
  public static List<caseWrapper> findAll(String orderBy, String order, String status) {
    List<caseWrapper> caseList = new List<caseWrapper>();
    if(status == 'Open'){
      try {

        System.debug(Logginglevel.ERROR, UserInfo.getUserId());

        String query = 'SELECT id, CaseNumber, Subject, Status, CreatedDate, LastModifiedDate FROM Case Where CreatedById = \'' + UserInfo.getUserId() + '\' AND isClosed = false Order By '
              + orderBy + ' ' + order + ' LIMIT 5000';

        System.debug(Logginglevel.ERROR, query);
        caseList = convertDates(Database.query(query));
      }
      catch (exception e) {
        throw new AuraHandledException('Some exception happened on server side controller with the following error:\n\n'+ e.getMessage());
      }
    }else if(status == 'Closed'){
      try {
        String query = 'SELECT id, CaseNumber, Subject, Status, CreatedDate, LastModifiedDate FROM Case Where CreatedDate >= LAST_N_YEARS:2  AND CreatedById = \'' + UserInfo.getUserId() + '\' AND isClosed = true Order By '
              + orderBy + ' ' + order;
        caseList = convertDates(Database.query(query));
      }
      catch (exception e) {
        throw new AuraHandledException('Some exception happened on server side controller with the following error:\n\n'+ e.getMessage());
      }
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
      cw.CaseLink = 'case/' + c.Id;

      cw.Subject = c.Subject;
      cw.Status = c.Status;
      cw.CreatedDate = c.CreatedDate.format('yyyy-MM-dd HH:mm:ss', userTimezone.getID());
      cw.LastModifiedDate = c.LastModifiedDate.format('yyyy-MM-dd HH:mm:ss', userTimezone.getID());
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
    @AuraEnabled
    public String CaseLink {get; set;}
    
    public caseWrapper(){

    }
  }


}