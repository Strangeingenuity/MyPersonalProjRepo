//TYAGA PATI: THIS IS THE CLASS FROM THE SALESFORCE TRAINING THAT HELPS CALL THE HEROKU WEB SERVICE TO VALIDATE ADDRESS.
// THIS CLASS MAKES A @FUTURE CALL TO THE ACTUAL REST WEB SERVICE
//THIS CLASS IS BEING CALLED FROM THE CANDIDATE TRIGGER.
//SEE HOW THE FLAG IS BEING CHEDKED BELOW. AsyncValidationFlag . THIS IS TO ENSURE AFTER THE RECORD IS SAVED BY THE FURTURE CALL CLASS, THE TRIGGER DOES NOT GET INVOKED AGAIN.
//Rest WebService Method to call out the Actual Web Service. This is being called out by the Trigger. validateAddressSOAP is the actual Web service
public class AddressValidationManager {
    public static Boolean AsyncValidationFlag = false;
    
    @Future(callout=true) 
    public static void validateAddressSOAP(Set<ID> ids) {
        try {
            // Build list of addresses to validate
            Map<ID, Candidate__c> mapCands = findCandidates(ids);
            List<ValidateAddressesBySOAP.addressSOAP> listAddress = new List<ValidateAddressesBySOAP.addressSOAP>();
            for (Candidate__c cand : mapCands.values()) {
                ValidateAddressesBySOAP.addressSOAP address = new ValidateAddressesBySOAP.addressSOAP();
                address.id = cand.id;
                address.line1 = cand.Street_Address_1__c;
                address.line2 = cand.Street_Address_2__c;
                address.city = cand.city__c;
                address.state = cand.state_Province__c;
                address.country = cand.country__c;
                address.zipCode = cand.zip_postal_code__c;
                listAddress.add(address);
            }
                        
            // Make callout
            ValidateAddressesBySOAP.ValidateAddressesPort port = new ValidateAddressesBySOAP.ValidateAddressesPort();
            List<ValidateAddressesBySOAP.validationResultSOAP> listResult = port.ValidateAddresses(listAddress);

            // Verify results
            for (ValidateAddressesBySOAP.validationResultSOAP result : listResult) {
                if (result.differences != null) {
                    //Following loop was added for debugging purposes
                    for (ValidateAddressesBySOAP.difference diff : result.differences) { 
                        System.debug('Field: [' + diff.fieldName + '] Expecting: [' + diff.expecting + '] Received: [' + diff.received + ']'); 
                    }
                } 
                
                Candidate__c cand = mapCands.get(result.testAddress.id);
                if (result.isValid) {
                    cand.Valid_Address__c = true;
                    cand.Address_Error__c = null;
                } else {
                    cand.Valid_Address__c = false;
                    cand.Address_Error__c = 'Invalid Address';                 
                }
            }
            
            // Update Candidate
            AsyncValidationFlag = true;
            update mapCands.values();
        } catch (Exception ex) {
            // Handle Exception
            System.debug('ERROR: '+ ex);
            Error_Log__c log = new Error_Log__c();
            log.trace__c = ex.getCause() + '\n' + ex.getMessage();
            insert log;        
        }
    }

    //TODO: Use the @future annotation to specify that the following method is to run asynchronously, and indicate that it will perform a web service callout
    @Future(callout=true)
    public static void validateAddressREST(Set<ID> ids) {
        try {
            // Build list of addresses to validate
            Map<ID, Candidate__c> mapCands = findCandidates(ids);
            List<ValidateAddressesByREST.Address> listAddress = new List<ValidateAddressesByREST.Address>();
            for (Candidate__c cand : mapCands.values()) {
                ValidateAddressesByREST.Address address = new ValidateAddressesByREST.Address();
                address.id = cand.id;
                address.line1 = cand.Street_Address_1__c;
                address.line2 = cand.Street_Address_2__c;
                address.city = cand.city__c;
                address.state = cand.state_Province__c;
                address.country = cand.country__c;
                address.zipCode = cand.zip_postal_code__c;
                listAddress.add(address);
            }
                        
            // Make callout
            //TODO: Declare a variable "port" of type ValidateAddressesByREST, and populate it using the default constructor
            ValidateAddressesByREST port = new ValidateAddressesByREST();
            //TODO: Call the ValidateAddresses method of "port" on the listAddress, and set the resulting list to a variable "listResult". 
            //NOTE: Review the class definition of ValidateAddressesByREST to find the return type of the ValidateAddresses()
            List<ValidateAddressesByREST.Result> listResult = port.ValidateAddresses(listAddress);

            // Verify results
            for (ValidateAddressesByREST.Result result : listResult) {
                if (result.differences != null) {
                    //Following loop was added for debugging purposes
                    for (ValidateAddressesByREST.ResultDifference diff : result.differences) { 
                        System.debug('Field: [' + diff.fieldName + '] Expecting: [' + diff.expecting + '] Received: [' + diff.received + ']'); 
                    }   
                }
                
                Candidate__c cand = mapCands.get(result.testAddress.id);
                if (result.isValid) {
                    cand.Valid_Address__c = true;
                    cand.Address_Error__c = null;
                } else {
                    cand.Valid_Address__c = false;
                    cand.Address_Error__c = 'Invalid Address';                 
                }
            }
            
            // Update Candidate
            AsyncValidationFlag = true;
            update mapCands.values();
        } catch (Exception ex) {
            // Handle Exception
            System.debug('ERROR: '+ ex);
            Error_Log__c log = new Error_Log__c();
            log.trace__c = ex.getCause() + '\n' + ex.getMessage();
            insert log;        
        }
    }
    
    private static Map<ID, Candidate__c> findCandidates(Set<ID> ids) {
        Map<ID, Candidate__c> output;
        output = new Map<ID, Candidate__c>([SELECT ID, Street_Address_1__c, Street_Address_2__c, city__c,
                                                state_Province__c, country__c, zip_postal_code__c
                                            FROM candidate__c
                                            WHERE id in :ids]);
        return output;
    }
}