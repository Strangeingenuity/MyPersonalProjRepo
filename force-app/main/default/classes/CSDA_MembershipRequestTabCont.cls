public with sharing class CSDA_MembershipRequestTabCont {
	@AuraEnabled
	// Get memberships that belong under the currently logged in contact
	public static List<EasyLife__membership__c> getMemberships(string membershipStatus) {
		List<EasyLife__CSDA_Membership_Status__c> statusList = EasyLife__CSDA_Membership_Status__c.getAll().values();
		Set<String> submittedStatusList = new Set<String>();
		Set<String> nonSubmittedStatusList = new Set<String>();
		List<EasyLife__membership__c> membershipList = new List<EasyLife__membership__c>();

		for (CSDA_Membership_Status__c eachStatus: statusList)
		{
			if (eachStatus.Submitted__c)
			{
				submittedStatusList.add(eachStatus.Name);
			}
			else
			{
				nonSubmittedStatusList.add(eachStatus.Name);
			}
		}

		// Only display membership requests and non revenue record types
        Set<String> recordTypeNames = new Set<String>{'Master','Membership_Non_Revenue', 'Membership_Request'};
        Set<String> statusListToQuery = new Set<String>();
		if (membershipStatus == 'Submitted')
		{
			statusListToQuery = submittedStatusList;
			//membershipList = [SELECT ID, Name,EasyLife__Account__r.Name,EasyLife__User_Entered_Account_Name__c FROM EasyLife__membership__c WHERE Status__c IN: submittedStatusList];
            
		}
		else if (membershipSTatus == 'Not Submitted')
		{
			statusListToQuery = nonSubmittedStatusList;
			//membershipList = [SELECT ID, Name,EasyLife__Account__r.Name FROM EasyLife__membership__c WHERE Status__c IN: nonSubmittedStatusList];
		}

         // Dynamic querying
        string query = 'SELECT ';
        //Schema.DescribeSObjectResult describeResult = Membership__c.sObjectType.getDescribe();
        //query += String.join(new List<String>(describeResult.fields.getMap().keySet()), ',');

        // Parent fields for membership
        /*query1 += ',EasyLife__Account__r.Name,EasyLife__Account__r.Company_URL_Domain__c,EasyLife__Account__r.BillingCity, EasyLife__Account__r.BillingPostalCode, EasyLife__Account__r.BillingState, Account__r.BillingStreet, Account__r.Phone,'
              + 'EasyLife__Opportunity__r.Owner.Sales_Team__c,EasyLife__Subsidiery_Account__r.Name,EasyLife__Subsidiery_Account__r.BillingCity, EasyLife__Subsidiery_Account__r.BillingPostalCode,Subsidiery_Account__r.BillingState, '
              + 'EasyLife__Subsidiery_Account__r.BillingStreet, EasyLife__Subsidiery_Account__r.Phone,EasyLife__Subsidiery_Account__r.Company_URL_Domain__c,EasyLife__RecordType.DeveloperName';
		*/
		query += 'Id, Name,EasyLife__Account__r.Name,RecordType.DeveloperName';



        // List of child relationship names to subquery
        Set<String> childRelToQuerySet = new Set<String>{'EasyLife__Membership_Contact__r', 'EasyLife__Membership_Address__r'};

        for(ChildRelationship relation : SObjectType.Membership__c.getChildRelationships()) {   
            String relationshipName = relation.getRelationshipName();
            SObjectType childType = relation.getChildSobject();

            if (relationshipName != null && childRelToQuerySet.contains(relationshipName)) {
                query += ', (SELECT ' + String.join(new List<String>(childType.getDescribe().fields.getMap().keySet()), ',') + ' FROM ' + relationshipName + ')';
            }
        }
         // Where clause for membership
        query += 'FROM EasyLife__Membership__c WHERE EasyLife__Status__c IN: statusListToQuery AND RecordType.DeveloperName IN: recordTypeNames';

        system.debug('Tyaga the query is 1111: ' +query);

        membershipList = Database.query(query);

		return membershipList;
	}
}