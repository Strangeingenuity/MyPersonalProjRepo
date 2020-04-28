public with sharing class CSDA_MembershipRequestFormCont {
    
    
    @AuraEnabled
    
    Public static void saveAll(
            EasyLife__Membership__c thisMembership, 
            List<EasyLife__Membership_Contact__c> contactList, 
            List<EasyLife__Membership_Contact__c> originalContactList, 
            List<EasyLife__Membership_Address__c> addressList, 
            List<EasyLife__Membership_Address__c> originalAddressList, 
            Boolean DQFlag)
        {

            system.debug('Tyaga the contact list now holds' + contactList);
            saveHelper(thisMembership,contactList,originalContactList,addressList,originalAddressList,DQFlag);

        }


    @AuraEnabled

    Public static void saveHelper(EasyLife__Membership__c thisMembership, 
            List<EasyLife__Membership_Contact__c> contactList, 
            List<EasyLife__Membership_Contact__c> originalContactList, 
            List<EasyLife__Membership_Address__c> addressList, 
            List<EasyLife__Membership_Address__c> originalAddressList, 
            Boolean DQFlag){
        system.debug('Tyaga SaveHelper Has been Called  : ' + contactList);
        contactList = checkContactData(contactList, thisMembership);
        checkAddressData(addressList);

        List<EasyLife__Membership_Contact__c> contactsToInsert = new List<EasyLife__Membership_Contact__c>();
        List<EasyLife__Membership_Contact__c> contactsToDelete = new List<EasyLife__Membership_Contact__c>();
        Set<ID> contactIDs = new Set<ID>();
        for (EasyLife__Membership_Contact__c eachContact: contactList)
        {
            if (eachContact.ID == null)
            {
                eachContact.Status__c = 'Pending Contact Association';
                contactsToInsert.add(eachContact);
            }
            else
            {
                contactIDs.add(eachContact.ID);
            }
        }
        // If contact was deleted, it will not be in contactIDs Set
        for (EasyLife__Membership_Contact__c eachContact: originalContactList)
            {
                if (!contactIDs.contains(eachContact.ID))
                {
                     contactsToDelete.add(eachContact);
                   }
                }

        // Delete any addresses marked for delete, insert new addresses
        List<EasyLife__Membership_Address__c> addToInsert = new List<EasyLife__Membership_Address__c>();
        List<EasyLife__Membership_Address__c> addToDelete = new List<EasyLife__Membership_Address__c>();
        Set<ID> addressIDs = new Set<ID>();
        for (EasyLife__Membership_Address__c eachAdd: addressList)
        {
            if (eachAdd.ID == null)
            {
                addToInsert.add(eachAdd);
            }
            else
            {
                addressIDs.add(eachAdd.ID);
            }
        }
        // If address was deleted, it will not be in addressIDs Set
        for (EasyLife__Membership_Address__c eachAdd: originalAddressList)
        {
            if (!addressIDs.contains(eachAdd.ID))
            {
                addToDelete.add(eachAdd);
            }
        }

        // Membership DQ flag
        if (DQFlag)
        {
            thisMembership.DQ_Team_Flag__c = true;
        }


        update thisMembership;
        insert contactsToInsert;
        delete contactsToDelete;
        insert addToInsert; 
        delete addToDelete;

        }


    // Contact Data Validation that must be done before saving
    // Return updated Contact List based on email domain matching
    Public static List<EasyLife__Membership_Contact__c> checkContactData(List<EasyLife__Membership_Contact__c> contactList, EasyLife__Membership__c thisMembership) {
        // Make sure there's only one contact per contact role
        Set<String> nonThirdPartyContRoles = new Set<String>();
        system.debug('Tyaga the contact list passed to this method is ' + contactList);
        // Make sure there's only one contact per contact role
        Integer count = 0;
            for(EasyLife__Membership_Contact__c eachContact : contactList){
                
                system.debug('tyaga the contact being iterated is : ' +  eachContact +'on count :' + count);
                if (string.isBlank(eachContact.First_Name__c)
                    || string.isBlank(eachContact.Last_Name__c) 
                    || string.isBlank(eachContact.Email__c)
                    || string.isBlank(eachContact.Phone_Number__c)
                    || string.isBlank(eachContact.Address__c)
                    || string.isBlank(eachContact.city__c)
                    || string.isBlank(eachContact.State__c)
                    || string.isBlank(eachContact.Zip__c)) {

                 
                 system.debug('name  :' + eachContact.First_Name__c +'  : last : '+ eachContact.EasyLife__Last_Name__c + ' : email :' +eachContact.EasyLife__Email__c + ' : phon :' +
                    eachContact.EasyLife__Phone_Number__c + 'address' + eachContact.EasyLife__Address__c + 'city' + eachContact.EasyLife__city__c + 
                    ' : state : ' + eachContact.EasyLife__State__c +  ' : zip : ' + eachContact.EasyLife__Zip__c);
                system.debug('Tyaga its ok till here 1111 ');

                 throw new AuraHandledException('Please populate all information for your membership contacts.');       


                }
          

                // Look for duplicate contact roles before saving
                // Third party contacts can have additional contract signers and head designates. 
                // We only care about these validations for non third party and applicant/bus principal contacts.
                if (!eachContact.Is_Third_Party__c || eachContact.Role__c == 'Applicant' || eachContact.Role__c == 'Business Principal') {
                    if (nonThirdPartyContRoles.contains(eachContact.Role__c)) {
                        //throw new AuraHandledException('Cannot have two contacts with the same role.');
                        throw new AuraHandledException('Cannot have two Applicant or Business Principal Contacts.');
                    }

                    nonThirdPartyContRoles.add(eachContact.Role__c);
                }

           

             if (eachContact.Is_Third_Party__c) {
                count++;
                if (string.isBlank(eachContact.Third_Party_Account__c) || string.isBlank(eachContact.Third_Party_Web_Address__c) || string.isBlank(eachContact.Third_Party_Role__c)) {
                    throw new AuraHandledException('Please populate all information for your membership contacts.');
                }
            }

            // If email domain doesn't match membership's account's domain, then mark a flag in the back end
            // 5/7/18: W-011356 Look for Subsidiery account domain as well
            // 6/15/18: I-2625 Use membership's business account field instead of account's company URL domain field
            /*
            if (!string.isBlank(thisMembership.Business_Website__c) && !eachContact.Email__c.contains(thisMembership.Business_Website__c)) {
                eachContact.Third_Party_Detected_By_Email_Domain__c = true;
            }
            */
            
            //if (!string.isBlank(thisMembership.Account__r.Company_URL_Domain__c) && !eachContact.Email__c.contains(thisMembership.Account__r.Company_URL_Domain__c)) {
                // If subsidiery account is null, then we just need to check account
            //    if (string.isBlank(thisMembership.Subsidiery_Account__r.Company_URL_Domain__c)) {
           //         eachContact.Third_Party_Detected_By_Email_Domain__c = true;
           //     }
                // If subsidiery account is not null, then check the email domain against the subsidiery's domain
               // else if (!eachContact.Email__c.contains(thisMembership.Subsidiery_Account__r.Company_URL_Domain__c)){
                //    eachContact.Third_Party_Detected_By_Email_Domain__c = true;
                //}
          //  }
            

        //}
    }//End of For loop

        // Make sure only 3 Third Party Contacts are saved
        if (count > 3) {
            throw new AuraHandledException('Maximum of 3 Third Party contacts can be added to a membership request.');
        }

        return contactList;
    }    


    @AuraEnabled

    Public static Void checkAddressData(List<EasyLife__Membership_Address__c> addressList){



    }


}