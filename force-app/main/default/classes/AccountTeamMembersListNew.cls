public with sharing class AccountTeamMembersListNew {
  
  public List<accountTeamWrapper> accountTeamMembers {get;set;}
  public List<accountTeamWrapper> newAccountTeamMembers {get;set;}
  public Account acc {get;set;}
  public Boolean showAddMemberSection {get;set;}
  public Boolean displayAccess {get;set;}
  public List<selectOption> accountOppAccessLevels {get;set;}
  public List<selectOption> caseAccessLevels {get;set;}
  public Id selectedId {get;set;}
  public Integer listSize {get;set;}
  public List<accountTeamWrapper> accountTeamMembersToShow {get;set;}
  public Integer currentSizeShown {get;set;}
  public Boolean reachedMax {get;set;}
  
  //==========================================================================
  // Constructor
  //==========================================================================
  public AccountTeamMembersListNew ( ApexPages.Standardcontroller std) {
    showAddMemberSection = false;
    displayAccess = false;
    currentSizeShown = 5;
    reachedMax = false;
    accountTeamMembersToShow = new List<accountTeamWrapper>();
    accountOppAccessLevels = new List<selectOption>();
    accountOppAccessLevels.add(new selectOption('Read','ReadOnly'));
    accountOppAccessLevels.add(new selectOption('Edit','ReadWrite'));
    caseAccessLevels = new List<selectOption>();
    caseAccessLevels.add(new selectOption('none','Private'));
    caseAccessLevels.add(new selectOption('Read','ReadOnly'));
    caseAccessLevels.add(new selectOption('Edit','ReadWrite'));
    Id accId = std.getRecord().Id;
    acc = [SELECT Id,Name 
           FROM Account
           WHERE Id = :accId];
    fetchExistingAccountTeamMembers();
    listSize = accountTeamMembers.size();
    if( listSize <= 5) {
        reachedMax = true;
    }

  }
  
  //==========================================================================
  // Method to fetch the existing Account Team Members and their access levels
  //==========================================================================
  public void fetchExistingAccountTeamMembers () {
    accountTeamMembers = new List<accountTeamWrapper> ();
    accountTeamMembersToShow = new List<accountTeamWrapper>();
    integer i = 0;

    map<Id,AccountShare> accShareMap = new map<Id,AccountShare>();
    for ( AccountShare accShare : [SELECT Id,OpportunityAccessLevel, CaseAccessLevel, UserOrGroupId
                                   FROM AccountShare
                                   WHERE AccountId = :acc.Id]) {
      accShareMap.put(accShare.UserOrGroupId,accShare);
    }
    for ( AccountTeamMember atm : [SELECT Id,TeamMemberRole,UserId,AccountId,
                                          AccountAccessLevel ,
                                          User.Name
                                   FROM AccountTeamMember 
                                   WHERE AccountId = :acc.Id
                                   order by User.Name ASC]) {
      accountTeamWrapper atWrap = new accountTeamWrapper();
      atWrap.member = atm;
      if(accShareMap != null && accShareMap.containsKey(atm.UserId)) {
        AccountShare accShare = accShareMap.get(atm.UserId);
        atWrap.caseAccess = accShare.CaseAccessLevel;
        atWrap.opportunityAccess = accShare.OpportunityAccessLevel;
      }
      accountTeamMembers.add(atWrap);
      if( i < 5) {
        accountTeamMembersToShow.add(atWrap);
        i++;
      }
      
    }
  }
  
 
  //==========================================================================
  // Method to show the access levels on the list view
  //==========================================================================
  public void showAccess (){
    displayAccess = true;
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'DiplayAccessInfo'));
  }
  

  //==========================================================================
  // Method to delete the account team member records
  //==========================================================================
  public PageReference doDelete() {
    try{
      if ( selectedId != null ) {
        integer indexToDel = -1;
        for (accountTeamWrapper atWrap :accountTeamMembers) {
          indexToDel++;
          if ( atWrap.member.Id == selectedId ) {
            break;
          }
        }
        if( indextoDel != -1) {
          accountTeamMembers.remove(indextoDel);
        }
        AccountTeamMember atmToDel = [SELECT Id,UserId,AccountId FROM AccountTeamMember WHERE Id = :selectedId];
        
        fetchExistingAccountTeamMembers();
      }
    }
    catch ( exception ex) {
      //apexLogHandler.createLogAndSave('AccountTeamMembersList','doDelete', ex.getStackTraceString(), ex);
      ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR, ex.getMessage()));
    }
    return null;
  }
  
  //==========================================================================
  // Method to show next set of records in the detail page
  //==========================================================================
  public void showMoreRecords() {
    integer loopEndVariable;
    if( currentSizeShown+5 < accountTeamMembers.size() ) {
      loopEndVariable = currentSizeShown+5;
    }
    else {
      loopEndVariable = accountTeamMembers.size();
      reachedMax = true;
    }
    for( integer i=currentSizeShown; i < loopEndVariable; i++) {
      accountTeamMembersToShow.add(accountTeamMembers[i]);
    }
    currentSizeShown = accountTeamMembersToShow.size();
  }
  
  //==========================================================================
  // Wrapper class to hold the Team Member record as well as their access levels
  //==========================================================================
  public class accountTeamWrapper {
    public AccountTeamMember member {get;set;}
    public String accountAccess {get;set;}
    public String opportunityAccess {get;set;}
    public String caseAccess {get;set;}
    public accountTeamWrapper() {
      member = new AccountTeamMember();
      opportunityAccess = '';
      caseAccess = '';
    }
  }
  
}