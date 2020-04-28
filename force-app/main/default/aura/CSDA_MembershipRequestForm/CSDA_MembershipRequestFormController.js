({
	doInit : function(component, event, helper) {
        helper.setMembershipChildren(component, event, helper);
		//helper.getMembership(component, event, helper);
        //helper.getResellerFile(component, event, helper);
        //helper.getPermPurpose(component, event, helper);
        //helper.getCurContact(component, event, helper);
        //helper.getUploadedResellerFile(component, event, helper);
	},
    
    

    AddContactRow : function(component, event,helper){
        console.log('test000007877787');
        console.log(component.get("v.membershipContacts"));
        //helper.createObjectData(component,event,EasyLife__Membership_Contact__c,component.get("v.membershipContacts"));
        helper.createObjectData(component, event, 'EasyLife__Membership_Contact__c', component.get('v.membershipContacts'));

    },


    save: function(component, event, helper){

        var DQFlag = true;
        var saveAll = component.get("c.saveAll");
        console.log ('printing contact');
        console.log(component.get("v.membershipContacts"));

        saveAll.setParams({
            "thisMembership":component.get("v.thisMembership"),
            "contactList": component.get("v.membershipContacts"),
            "originalContactList":component.get("v.originalContactList"),
            "addressList":component.get("v.addressList"),
            "originalAddressList":component.get("v.originalAddressList"),
            "DQFlag": DQFlag
        });
        console.log('printing original contact list');
        console.log(component.get("v.originalMembershipContacts"));
        saveAll.setCallback(this,function(a){
            var state = a.getState();
            if(component.isValid() && state == "SUCCESS"){

                var resultToast = $A.get("e.force:showToast");
                alert('fired');
                resultToast.setParams({
                        "type": "success",
                        "title": "Result",
                        "message": "Saved"
                    });
                    resultToast.fire(); 
                    
                    //helper.rerenderPage(component, event, helper);
            }
            
            else 
            {
                var errors =a.getError();
                if(errors){
                   var errorMsg = "Error";
                   if(errors[0]&&errors[0].message){
                    errorMsg = errors[0].message;

                   }

                   else{

                        if( errors[0]!= undefined && errors[0].fieldErrors.Email__c ){
                           errorMsg = errors[0].fieldErrors.Email__c.message;

                        }

                        else if (error[0]!=undefined && errors[0].pageErrors.lenght>0)
                        {
                            errorMsg = error[0].pageErrors[0].message;


                        }
                   }

                   var resultToast = $A.get("e.force.showToast");
                   resultToast.setParams({
                        "type" : "error",
                        "title" : "Error",
                        "message": errorMsg
                   });

                   resultToast.fire();
                   console.log('error from save');
                   console.log(errors);
                }
            }
 
    });
        $A.enqueueAction(saveAll);
    
    }
    
    })