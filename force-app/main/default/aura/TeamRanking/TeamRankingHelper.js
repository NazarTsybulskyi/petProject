({
    getAllConfTeamsHelper : function(component, event, helper) {
        var getConfTeamListAction = component.get("c.getConfTeamList");
		getConfTeamListAction.setParams({
		   "recordId" : component.get("v.recordId")
        });
        getConfTeamListAction.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                component.set("v.confTeams", response.getReturnValue());   
            } else {
			    console.log("Response state: " + response.getState());
			}
        });
        $A.enqueueAction(getConfTeamListAction);
    }

})