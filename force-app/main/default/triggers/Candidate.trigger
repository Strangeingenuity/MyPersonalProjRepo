//THIS IS THE TRIGGER THAT GETS CALLED WHEN ADDRESS IS CHANGED ON A CANDIDATE RECORD. 
//THIS IN TURN CALLED THE AddressManager class.

trigger Candidate on Candidate__c (before insert, after insert, before update, after update) {
    // Check the AsyncValidationFlag to determine if this is comming from the future method
    if (!AddressValidationManager.AsyncValidationFlag) {
        Set<ID> ids = new Set<ID>();
        for (Candidate__c newCand : trigger.new) {
            Candidate__c oldCand;
            
            // trigger.old can't be used on a insert trigger.
            if (Trigger.isInsert) {
                oldCand = new Candidate__c();
            } else {
                oldCand = Trigger.oldMap.get(newCand.ID);
            }
            
            // Does this record need to be processed?
            if ((Trigger.isInsert) ||
                (newCand.Street_Address_1__c != oldCand .Street_Address_1__c) ||
                (newCand.Street_Address_2__c != oldCand .Street_Address_2__c) ||
                (newCand.City__c != oldCand .City__c) ||
                (newCand.State_Province__c != oldCand .State_Province__c) ||
                (newCand.Country__c != oldCand .Country__c) ||
                (newCand.Zip_Postal_Code__c != oldCand .Zip_Postal_Code__c)) {
                
                if (trigger.isBefore) {
                    newCand.Valid_Address__c = false;
                    newCand.Address_Error__c = '--- Please refresh the page to view the results of the address validation request. --- ';
                } else {
                    ids.add(newCand.id);                
                }
            }
        }
        
        // Call asynchronous method to validate addresses.
        if ((trigger.isAfter) && (ids.size() > 0)) {
            //TODO: Call the validateAddressSOAP method, passing in "ids" as the parameter
            AddressValidationManager.validateAddressSOAP(ids);
            //AddressValidationManager.validateAddressREST(ids);
         }
    }
}