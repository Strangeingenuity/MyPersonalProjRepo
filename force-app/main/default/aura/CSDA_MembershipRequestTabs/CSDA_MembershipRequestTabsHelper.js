({
	loadTabs : function(component, event) {
		var tab = event.getSource();
        var membershipStatus = component.get("v.membershipStatus")

		if (membershipStatus == 'Not Submitted')
		{
            console.log('Code is executed')
			this.injectEditForm(component, 'c:CSDA_MembershipRequestForm', tab);
		}
		else if (membershipStatus  == 'Submitted')
		{
			this.injectReadForm(component, 'c:CSDA_DocTabs', tab);
		}
	},

	injectEditForm: function (component, name, target) {
        $A.createComponent(
        	name, 
        	{
        		"thisMembership": component.get("v.selTabId")
        		//"questionnaireLink": component.get("v.questionnaireLink"),
        		//"permPurposeOptions": component.get("v.permPurposeOptions"),
        		//"curUserContact": component.get("v.curUserContact")
	        }, 
	        function (contentComponent, status, error) {
	            if (status === "SUCCESS") 
	            {
                    console.log('code is here 111');
	                target.set('v.body', contentComponent);
	            } 
	            else 
	            {
	                throw new Error(error);
                    console.log(error);
	            }
        	}
        );
    },

    /*injectReadForm: function (component, name, target) {
        $A.createComponent(
        	name, 
        	{
        		"thisMembership": component.get("v.selTabId"),
                "membershipContacts": component.get("v.selTabId").Membership_Contacts__r,
                "membershipAddresses": component.get("v.selTabId").Membership_Address__r
	        }, 
	        function (contentComponent, status, error) {
	            if (status === "SUCCESS") 
	            {
	                target.set('v.body', contentComponent);
	            } 
	            else 
	            {
	                throw new Error(error);
	            }
        	}
        );
    },

    getResellerFile: function(component, event, helper) {
        var getResellerFile = component.get("c.getResellerFile");
        $A.enqueueAction(getResellerFile);

        getResellerFile.setCallback(this, function(a){
            var state = a.getState();
            if (component.isValid() && state === "SUCCESS") {
                var respon = a.getReturnValue();
                //var link = '/sfc/servlet.shepherd/document/download/' + respon;
                var link = '/CSDAMemOnboarding/servlet/servlet.FileDownload?file=' + respon;
                component.set("v.questionnaireLink", link);
            }
        });
    },

    getPermPurpose: function(component, event, helper) {
        var getPermPurpose = component.get("c.getPermPurpose");
        $A.enqueueAction(getPermPurpose);
        getPermPurpose.setCallback(this, function(a){
            var state = a.getState();
            if (component.isValid() && state === "SUCCESS") {
                var respon = a.getReturnValue();
                var opts = [];
                
                for (var i=0; i<respon.length; i++)
                {
                    var eachOption = 
                    {
                        label: respon[i].Client_Approaching_Experian__c + ': \n' + respon[i].Client_Facing_Permissible_Purposes__c,
                        value: respon[i].Client_Approaching_Experian__c
                    }
                    opts.push(eachOption);
                }

                opts.push({label:'Other', value:'Other'});
                //component.find("permPurposeList").set("v.options", opts);
                component.set("v.permPurposeOptions", opts);
            }
        });
    },

    getCurContact: function(component, event, helper) {
        // Get the current logged in user's contact info
        // W-011361: This is so we can auto populate some membership contacts
        var getCurContact = component.get("c.getCurContact");
        $A.enqueueAction(getCurContact);
        getCurContact.setCallback(this, function(a){
            var state = a.getState();
            if (component.isValid() && state === "SUCCESS") {
                var respon = a.getReturnValue();
                component.set("v.curUserContact", respon);
            }
        });
    }, 
*/
    getMemberships: function(component, event, helper) {
		var getMemberships = component.get("c.getMemberships");
		getMemberships.setParams({"membershipStatus":component.get("v.membershipStatus")});
        $A.enqueueAction(getMemberships);
        getMemberships.setCallback(this, function(a){
            var state = a.getState();
            if (component.isValid() && state === "SUCCESS") {
            	var respon = a.getReturnValue();
                component.set("v.allMemberships", respon);
            }
        });


    }
})