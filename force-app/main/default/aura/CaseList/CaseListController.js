({
    doInit : function(component, event, helper) {
        component.set("v.orderBy", "CreatedDate");
        component.set("v.order", "DESC");
        component.find("CreatedDateDir").set("v.value","▼");
        
        var action = component.get("c.findAll");
        action.setParams({"orderBy":component.get("v.orderBy"),"order":component.get("v.order")});

        var objAry = [];

        action.setCallback(this, function(a) {

            var respon = a.getReturnValue()

            for (var i in respon) {
                var caseObj = {
                    type: "Salesforce Case",
                    CaseNumber: respon[i].CaseNumber,
                    Id: respon[i].Id,
                    Status: respon[i].Status,
                    Subject: respon[i].Subject,
                    CreatedDate: respon[i].CreatedDate,
                    LastModifiedDate: respon[i].LastModifiedDate
                }
                objAry.push(caseObj);
            }


            // do another web api call out get service now cases
            var sNowResponse = "{\"result\":[{\"number\":\"REQ0010002\",\"opened_at\":\"2016-09-08 11:00:42\",\"request_state\":\"closed_complete\",\"stage\":\"closed_complete\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-09-13 11:00:42\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010015\",\"opened_at\":\"2016-09-21 15:49:16\",\"request_state\":\"closed_complete\",\"stage\":\"closed_complete\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-09-26 15:49:16\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010003\",\"opened_at\":\"2016-09-08 16:45:43\",\"request_state\":\"closed_complete\",\"stage\":\"closed_complete\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-09-13 16:45:43\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010001\",\"opened_at\":\"2016-08-18 11:09:46\",\"request_state\":\"in_process\",\"stage\":\"requested\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-08-23 11:09:46\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010063\",\"opened_at\":\"2016-10-10 10:22:59\",\"request_state\":\"in_process\",\"stage\":\"requested\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-10-12 10:22:58\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010057\",\"opened_at\":\"2016-10-05 14:42:17\",\"request_state\":\"in_process\",\"stage\":\"requested\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-10-06 04:42:16\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010012\",\"opened_at\":\"2016-09-20 13:54:32\",\"request_state\":\"requested\",\"stage\":\"requested\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-09-25 13:54:31\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010367\",\"opened_at\":\"2016-11-30 10:03:09\",\"request_state\":\"requested\",\"stage\":\"requested\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-12-02 10:03:09\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010013\",\"opened_at\":\"2016-09-20 15:50:23\",\"request_state\":\"in_process\",\"stage\":\"requested\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-09-22 15:50:23\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}},{\"number\":\"REQ0010011\",\"opened_at\":\"2016-09-20 13:51:44\",\"request_state\":\"requested\",\"stage\":\"requested\",\"opened_by\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"},\"due_date\":\"2016-09-25 13:51:43\",\"requested_for\":{\"link\":\"https://experiandev.service-now.com/api/now/table/sys_user/7be43e25db2c62002511fa910f9619bd\",\"value\":\"7be43e25db2c62002511fa910f9619bd\"}}]}";
            var sNowResponseObj = JSON.parse(sNowResponse);

            var sNowResponseArray = [];
            for(var i in sNowResponseObj.result){
                var caseObj = {
                    type: "ServiceNow Case",
                    CaseNumber: sNowResponseObj.result[i].number,
                    Id: "",
                    Link: sNowResponseObj.result[i].opened_by.link,
                    Status: sNowResponseObj.result[i].stage,
                    Subject: "",
                    CreatedDate: sNowResponseObj.result[i].opened_at,
                    LastModifiedDate: ""
                }
                // merge data set into objAry
                objAry.push(caseObj);
            }
            

            objAry.sort(helper.sortBy('CreatedDate',-1));  // <<- default sorting ?

            component.set("v.completeListCases", objAry);
            component.set("v.cases", objAry);


            var recordsPerPage = parseInt(component.get("v.recordsPerPage"));
            component.set("v.currentPageCases", component.get("v.cases").slice( 0, recordsPerPage));

            var totalPageNumber = Math.ceil(component.get("v.cases").length / recordsPerPage);

            component.set("v.lastPageNumber", totalPageNumber);

        });
        $A.enqueueAction(action);
    },
    
    // searchKeyChange: function(component, event) {
    //     var searchKey = event.getParam("searchKey");
    //     //var searchType = event.getParam("searchType");
    //     var action = component.get("c.findBySearch");
    //     action.setParams({"searchKey": searchKey,
    //                       "searchType": component.find("searchTypeSelection").get("v.value"),
    //                       "orderBy":component.get("v.orderBy"),
    //                       "order":component.get("v.order")});
    //     action.setCallback(this, function(a) {component.set("v.cases", a.getReturnValue());});
    //     $A.enqueueAction(action);
    // },
    
    SearchKeyFireEvent: function(component, event) {
        var myEvent = $A.get("e.EasyLife:CaseListSearchKeyChange");
        myEvent.setParams({"searchKey": event.target.value});
        myEvent.fire();
    },
    
    // sort: function(component, event){


    //     var whichOne = event.getSource().getLocalId();

    //     if(whichOne == component.get("v.orderBy")) {
    //         if(component.get("v.order") == "DESC"){
    //             component.set("v.order","ASC");
    //         }else{
    //             component.set("v.order","DESC");
    //         }
    //     } else{
    //         component.set("v.orderBy",whichOne);
    //         component.set("v.order","DESC");
    //     }

        

    //     var action = component.get("c.findBySearch");
    //     var searchKey = event.getParam("searchKey");
    //     if (searchKey == undefined) {
    //         searchKey = '';
    //     }
        
    //     action.setParams({"searchKey": searchKey,
    //                       "searchType": component.find("searchTypeSelection").get("v.value"),
    //                       "orderBy" : component.get("v.orderBy"),
    //                       "order" : component.get("v.order")
    //                     });


    //     action.setCallback(this, function(response) {

    //         var state = response.getState();

    //         if (component.isValid() && state === "SUCCESS") {
    //             console.log(response.getReturnValue());
    //             component.set("v.cases", response.getReturnValue());
    //         }
    //         else if (component.isValid() && state === "INCOMPLETE") {
    //             // do something
    //         }
    //         else if (component.isValid() && state === "ERROR") {
    //             var errors = response.getError();
    //             if (errors) {
    //                 if (errors[0] && errors[0].message) {
    //                     console.log("Error message: " + 
    //                              errors[0].message);
    //                 }
    //             }
    //         }
    //     });
    //     $A.enqueueAction(action);
    // },

    sortLocal: function(component, event, helper){


        var whichOne = event.getSource().getLocalId();

        if(whichOne == component.get("v.orderBy")) {
            if(component.get("v.order") == "DESC"){
                component.set("v.order","ASC");
            }else{
                component.set("v.order","DESC");
            }
        } else{
            component.set("v.orderBy",whichOne);
            component.set("v.order","DESC");
        }

        var objAry = component.get("v.cases");


        if (component.get("v.order") == "DESC") {
            objAry.sort(helper.sortBy(whichOne, -1));
        }
        else {
            objAry.sort(helper.sortBy(whichOne));
        }

        component.set("v.cases", objAry);
        var recordsPerPage = parseInt(component.get("v.recordsPerPage"));
        component.set("v.currentPageNumber", '1');
        component.set("v.currentPageCases", component.get("v.cases").slice( 0, recordsPerPage));

        
    },


    searchLocal : function(component, event, helper) {
        var searchKey = event.getParam("searchKey");
        var searchType = component.find("searchTypeSelection").get("v.value");


        var objAry = component.get("v.completeListCases");

        var filteredArray = [];

        if (searchKey.length > 0) {
            for (var i in objAry) {
                if (objAry[i][searchType] != undefined && objAry[i][searchType].toLowerCase().includes(searchKey.toLowerCase())) {
                    filteredArray.push(objAry[i]);
                }
            }

            component.set("v.cases", filteredArray);
        }
        else {
            component.set("v.cases", objAry);
        }
        var recordsPerPage = parseInt(component.get("v.recordsPerPage"));
        component.set("v.currentPageNumber", '1');
        component.set("v.currentPageCases", component.get("v.cases").slice( 0, recordsPerPage));
    },

    previousPage : function(component, event, helper) {

        var recordsPerPage = component.get("v.recordsPerPage");
        var currentPage = parseInt(component.get("v.currentPageNumber"));
        var lastPageNum = Math.ceil(component.get("v.cases").length / recordsPerPage);

        if (currentPage > 1) {
            currentPage--;

            component.set("v.currentPageNumber", currentPage);
            component.set("v.currentPageCases", component.get("v.cases").slice( (currentPage-1) * recordsPerPage , currentPage * recordsPerPage));
        }
    },

    nextPage : function(component, event, helper) {
        var recordsPerPage = component.get("v.recordsPerPage");
        var currentPage = parseInt(component.get("v.currentPageNumber"));
        var lastPageNum = Math.ceil(component.get("v.cases").length / recordsPerPage);

        if (currentPage < lastPageNum) {
            currentPage++;

            component.set("v.currentPageNumber", currentPage);
            component.set("v.currentPageCases", component.get("v.cases").slice( (currentPage-1) * recordsPerPage , currentPage * recordsPerPage));
        }
    },

    pageNumberChanged : function(cmp, event) {
        // check input valid
        var enteredPageNumber = cmp.get("v.currentPageNumber");
        var isPositiveInt = /^\+?([1-9]\d*)$/.test(enteredPageNumber);

        if (isPositiveInt == false) {
            cmp.set("v.currentPageNumber", cmp.get("v.lastValidPageNumber"));
            alert('Please enter a valid page number');
        }
        else {

            // Validate current page number within range (currently possible from 1 - infinity)
            var lastPageNum = parseInt(cmp.get("v.lastPageNumber"));
            var recordsPerPage = parseInt(cmp.get("v.recordsPerPage"));


            if (enteredPageNumber >= 1 && parseInt(enteredPageNumber) <= parseInt(lastPageNum)) {
                cmp.set("v.lastValidPageNumber", enteredPageNumber);
                cmp.set("v.currentPageCases", cmp.get("v.cases").slice( (enteredPageNumber-1) * recordsPerPage , enteredPageNumber * recordsPerPage));
            }
            else {
                cmp.set("v.currentPageNumber", cmp.get("v.lastValidPageNumber"));
                alert("Please enter a page number within 1 to " + lastPageNum);
            }
        }
        
    }
})