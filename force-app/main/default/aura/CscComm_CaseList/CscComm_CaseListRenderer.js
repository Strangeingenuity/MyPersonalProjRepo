({
    // Your renderer method overrides go here
    rerender: function(component, helper) {

        var recordsPerPage = parseInt(component.get("v.recordsPerPage"));

        var totalPageNumber = Math.ceil(component.get("v.cases").length / recordsPerPage);

        var currentPage = parseInt(component.get("v.currentPageNumber"));

        component.set("v.lastPageNumber", totalPageNumber);

        if (totalPageNumber == 0) {

            var pageNumberDiv = component.find("page-number-div");
            $A.util.addClass(pageNumberDiv, "hide-div");

            var preBtn = component.find("cccl_preBtn");
            preBtn.set("v.disabled", true);

            var nxtBtn = component.find("cccl_nxtBtn");
            nxtBtn.set("v.disabled", true);
        }
        else {
            var pageNumberDiv = component.find("page-number-div");
            $A.util.removeClass(pageNumberDiv, "hide-div");

            if (currentPage == 1) {
                var preBtn = component.find("cccl_preBtn");
                preBtn.set("v.disabled", true);
            }
            else {
                var preBtn = component.find("cccl_preBtn");
                preBtn.set("v.disabled", false);
            }

            if (currentPage == totalPageNumber) {
                var nxtBtn = component.find("cccl_nxtBtn");
                nxtBtn.set("v.disabled", true);
            }
            else {
                var nxtBtn = component.find("cccl_nxtBtn");
                nxtBtn.set("v.disabled", false);
            }
        }

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
        
    }
})