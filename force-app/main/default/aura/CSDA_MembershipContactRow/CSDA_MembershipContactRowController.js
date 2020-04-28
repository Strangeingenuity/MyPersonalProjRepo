({
	init : function(component, event, helper) {
		console.log("Before Contact component initial");
		helper.initializeRoleOptions(component);
		console.log("After Contact component initial");
	},


	removerow : function(component,event,helper){
		if(confirm("Are you sure?"))
		{
			component.getEvent("DeleteRowEvt").setParams(
			{
				"indexVar":component.get("v.rowIndex"),
				"objectType":"Membership_Contact__c"
			}).fire();

			}
		},

    SQDChange: function(component, event, helper) {
        helper.initializeRoleOptions(component);
    }


})