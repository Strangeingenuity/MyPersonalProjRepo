({
    // Your renderer method overrides go here
    rerender: function(component, helper) {

        var recordsPerPage = parseInt(component.get("v.recordsPerPage"));

        var totalPageNumber = Math.ceil(component.get("v.cases").length / recordsPerPage);

        component.set("v.lastPageNumber", totalPageNumber);

        //Set sort direction indicator
        component.find("CaseNumberDir").set("v.value","");
        component.find("SubjectDir").set("v.value","");
        component.find("StatusDir").set("v.value","");
        component.find("CreatedDateDir").set("v.value","");
        component.find("LastModifiedDateDir").set("v.value","");


        var order = component.get("v.order");
        var orderBy = component.get("v.orderBy");
        var selectedCol = "" + orderBy + "Dir";


        if (order == "DESC") {
        	component.find(selectedCol).set("v.value", "▼");
        }
        else {
        	component.find(selectedCol).set("v.value", "▲");
        }
        

        // var currentPage = parseInt(component.get("v.currentPageNumber"));
        // if (currentPage == 1) {
        //     console.log('disabling pre page btn');
        //     component.find("prePageBtn").set("v.disabled", true);
        // }
        // else {
        //     console.log('enabling pre page btn');
        //     component.find("prePageBtn").set("v.disabled", false);
        // }

        // if (currentPage == totalPageNumber) {
        //     console.log('disabling next page btn');
        //     component.find("nextPageBtn").set("v.disabled", true);
        // }
        // else {
        //     console.log('enabling next page btn');
        //     //component.find("nextPageBtn").set("v.disabled", false);
        // }

        // console.log(component.find("nextPageBtn"));
    }
})