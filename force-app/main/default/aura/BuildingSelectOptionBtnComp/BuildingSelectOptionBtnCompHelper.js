({
	addSelectedBuildingOptions : function(component, event, selectedIDs) {
		var addBuildingOptionsAction = component.get('c.addBuildingOptions');
		    addBuildingOptionsAction.setParams({
                "parentId": component.get("v.recordId"), 
                "selectedProductIDs": selectedIDs			
        });
 
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
            }
        });
        $A.enqueueAction(addBuildingOptionsAction);
    },	
})