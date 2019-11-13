({
	init: function (component, event, helper) {
		var getAllAccountLocationsAction = component.get("c.getAllAccountLocations");
		getAllAccountLocationsAction.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
				component.set("v.mapMarkers", response.getReturnValue()); 
				component.set("v.zoomLevel", 1);
				//component.set("v.center", )
				console.log('current zoom level -->>> ' + component.getZoom());
            } else {
				console.log("Response state: " + response.getState() + ': ' + response.getMessage());
			}
        });
        $A.enqueueAction(getAllAccountLocationsAction);
	},
})