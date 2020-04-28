({
	sumThetwoNums : function(component, event, helper) {
        var fNum = component.get("v.fitstNum");
        var sNum = component.get("v.SecondNum");
        var sum = fNum+sNum;
        component.set("v.sumTotal",sum);

        
	}
})