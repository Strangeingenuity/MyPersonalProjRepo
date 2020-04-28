({
	createObjectData: function(component, event, objectType, dataList) {
        var objectData = {
            'sobjectType': objectType,
            'EasyLife__Membership_Contact__c': component.get("v.thisMembership.Id"),
            'EasyLife__Membership_Contact__r': null,
            'isNewRecord': true
        };
        console.log('tyaga here');
        console.log(objectType);
        if (objectType == 'EasyLife__Membership_Contact__c')
        {
            dataList.push(objectData);
            component.set("v.membershipContacts", dataList);
            console.log('tyaga the new contact list is');
            console.log(component.get("v.membershipContacts"));
        }
        else if (objectType == 'EasyLife__Membership_Address__c')
        {
            objectData.Type__c = 'Branch';
            objectData.Account_Name__c = component.get("v.thisMembership.Account__r.Name");
            dataList.push(objectData);
            component.set("v.membershipAddresses", dataList);
        }
        
    },


    setMembershipChildren: function(component, event, helper){
        
        var membershipContacts = [];
        var membershipAddresses = [];
        var respon = component.get("v.thisMembership");

        if (respon.EasyLife__Membership_Contact__r != undefined)
        {
            for (var i=0; i<respon.EasyLife__Membership_Contact__r.length; i++)
           
            {
                membershipContacts.push(respon.EasyLife__Membership_Contact__r[i]);
            }

            
        }
        if (respon.EasyLife__Membership_Address__r != undefined)
        {
            for (var i=0; i<respon.EasyLife__Membership_Address__r.length; i++)
            {
                membershipAddresses.push(respon.EasyLife__Membership_Address__r[i]);
            }
        }
        
        component.set("v.membershipContacts", membershipContacts);
        //console.log('The list holds following contacts');
        //console.log(component.get("v.membershipContacts"));
        component.set("v.originalMembershipContacts", membershipContacts);

    }



})