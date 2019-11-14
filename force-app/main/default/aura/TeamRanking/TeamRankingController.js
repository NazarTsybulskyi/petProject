({
    init : function(component, event, helper) {
	    component.set("v.teamColumns",[
		    {label: 'Team', fieldName: 'Name', type: 'text'},
		    {label: 'W', fieldName: 'W__c', type: 'number'},
		    {label: 'L', fieldName: 'L__c', type: 'number'},
			{label: 'PCT', fieldName: 'PCT__c', type: 'number'}
		]);
        helper.getAllConfTeamsHelper(component, event, helper);
    }
})
