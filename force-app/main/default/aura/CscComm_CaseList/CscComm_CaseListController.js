({
    doInit : function(component, event, helper) {
        component.set("v.orderBy", "CreatedDate");
        component.set("v.order", "DESC");
        component.find("CreatedDateDir").set("v.value","▼");

        var selectedCaseStatus = component.get("v.caseStatus");

        if (selectedCaseStatus == 'Open') {
            //component.set("v.translatedTitle", $A.get("$Label.c.CustCom_Open"));
            component.set("v.translatedTitle", "Open");
        }
        else {
            //component.set("v.translatedTitle", $A.get("$Label.c.CustCom_Close"));
            component.set("v.translatedTitle", "Closed");
        }
        
        var action = component.get("c.findAll");
        action.setParams({"orderBy":component.get("v.orderBy"),
                            "order":component.get("v.order"),
                            "status":selectedCaseStatus
                        });

        var objAry = [];

        action.setCallback(this, function(a) {

            var state = a.getState();
            if (component.isValid() && state === "SUCCESS") {
                var respon = a.getReturnValue()

                for (var i in respon) {
                    var caseObj = {
                        CaseNumber: respon[i].CaseNumber,
                        Id: respon[i].Id,
                        Status: respon[i].Status,
                        Subject: respon[i].Subject,
                        CreatedDate: respon[i].CreatedDate,
                        LastModifiedDate: respon[i].LastModifiedDate,
                        CaseLink: respon[i].CaseLink
                    }
                    objAry.push(caseObj);
                }


                objAry.sort(helper.sortBy('CreatedDate',-1));  // <<- default sorting ?

                component.set("v.completeListCases", objAry);
                component.set("v.cases", objAry);


                var recordsPerPage = parseInt(component.get("v.recordsPerPage"));
                component.set("v.currentPageCases", component.get("v.cases").slice( 0, recordsPerPage));

                var totalPageNumber = Math.ceil(component.get("v.cases").length / recordsPerPage);

                component.set("v.lastPageNumber", totalPageNumber);
            }
            else if (component.isValid() && state === "ERROR") {
                var errors = a.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    SearchKeyFireEvent: function(component, event) {

        console.log(event);

        var myEvent = $A.get("e.c:CaseListSearchKeyChange");
        myEvent.setParams({"searchKey": event.target.value});
        myEvent.fire();
    },

    SearchKeyChangeEvent: function(component, event) {
        var searchKey = event.getParam("value");
        var searchType = component.find("searchTypeSelection").get("v.value");
    },

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
        var searchKey = event.getParam("value");
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


            if (parseInt(enteredPageNumber) >= 1 && parseInt(enteredPageNumber) <= parseInt(lastPageNum)) {
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