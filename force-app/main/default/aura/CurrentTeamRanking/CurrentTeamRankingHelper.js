({
	getConfTeamsHelper : function(component, event, helper) {
		
		var getConfTeamsHelperAction = component.get("c.getConfTeamList");
		getConfTeamsHelperAction.setParams({
		   "teamId" : component.get("v.recordId")
        });
        getConfTeamsHelperAction.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                component.set('v.confList', response.getReturnValue());   
            } else {
			    console.log("Response state: " + response.getState());
			}
        });
        $A.enqueueAction(getConfTeamsHelperAction);
    },

	getDivisionTeamsHelper : function(component, event, helper) {
	    var getDivisionTeamsHelperAction = component.get("c.getDivTeamList");
		getDivisionTeamsHelperAction.setParams({
		   "teamId" : component.get("v.recordId")
        });
        getDivisionTeamsHelperAction.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                component.set('v.divList', response.getReturnValue());   
            } else {
			    console.log("Response state: " + response.getState());
			}
        });
        $A.enqueueAction(getDivisionTeamsHelperAction);
    },
	
})