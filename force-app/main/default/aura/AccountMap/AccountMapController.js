({
	init: function (component, event, helper) {
		var getAllAccountLocationsAction = component.get("c.getAllAccountLocations");
		getAllAccountLocationsAction.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
				component.set("v.mapMarkers", response.getReturnValue()); 
				component.set("v.zoomLevel", 4.35);
            } else {
				console.log('Error: '  + response.getMessage());
			}
        });
        $A.enqueueAction(getAllAccountLocationsAction);
	},
})