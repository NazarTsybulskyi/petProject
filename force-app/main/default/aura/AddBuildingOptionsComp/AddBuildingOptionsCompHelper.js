({
	getProductsListHelper : function(component, event, helper) {
        var productsListDataAction = component.get("c.getProductsList");
		productsListDataAction.setParams({recordId: component.get('v.recordId')});
		productsListDataAction.setCallback(this, $A.getCallback(function(response) {
            if (response.getState() == "SUCCESS"){
			    var prods = response.getReturnValue();
				console.log(prods);
				for (var i = 0; i < prods.length; i++) {
					prods[i].coFinanceDisabled = !prods[i].Co_finance_allowed__c;
					prods[i].coFinanceSelected = false;
					prods[i].coFinanceIcon = 'utility:add';
			    }  
                component.set('v.products', prods);   
            } else {
			    console.log("Response state: " + response.getState());
			}
        }));
		$A.enqueueAction(productsListDataAction);    
    },

	addBuildingOptionsHelper : function(component, event, selectedIdToCoFinance) {
		var addBuildingOptionsAction = component.get('c.addBuildingOptions');
		addBuildingOptionsAction.setParams({
            "parentId": component.get("v.recordId"), 
            "selectedProducts": JSON.stringify(selectedIdToCoFinance)			
        });
		console.log('map in helper = ' + JSON.stringify(selectedIdToCoFinance));
 
        addBuildingOptionsAction.setCallback(this, function(response) {
            var state = response.getState();
            if (response.getState() == "SUCCESS") {
			    $A.get('e.force:closeQuickAction').fire();
                var toastEvent = $A.get("e.force:showToast");
          			toastEvent.setParams({
        				"title": "Success!",
        				"message": "The Building Options has been added successfully.",
						"type": 'success'
    				});
                    toastEvent.fire(); 
					$A.get('e.force:refreshView').fire();                 
            } else {
			    console.log("Response state: " + response.getState() + '; ' + response.getBody());
			}
        });
        $A.enqueueAction(addBuildingOptionsAction);
    }

});