({
	doInit : function(component, event, helper) {
  		console.log('here inside doinit');
        helper.getMemberships(component, event, helper);
        //helper.getResellerFile(component, event, helper);
        //helper.getPermPurpose(component, event, helper);
        //helper.getCurContact(component, event, helper);
	},

	handleActive : function(component, event, helper) {
		console.log('here inside handleActive');
        helper.loadTabs(component, event);
	},
})