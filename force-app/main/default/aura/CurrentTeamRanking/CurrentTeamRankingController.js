({
	init : function(component, event, helper) {
	    component.set('v.teamColumns',[
		    {label: 'Team', fieldName: 'Name', type: 'text'},
		    {label: 'W', fieldName: 'W__c', type: 'number'},
		    {label: 'L', fieldName: 'L__c', type: 'number'},
			{label: 'PCT', fieldName: 'PCT__c', type: 'number'}
		]);
		component.find("confId").getElement().className = "slds-tabs--scoped__item slds-text-title--caps slds-active customClassForTab";
		component.find("confDataId").getElement().className = "slds-tabs--scoped__item slds-text-title--caps slds-active customClassForTab";
	    helper.getConfTeamsHelper(component, event, helper);
		
	},

	loadDivTeams : function(component, event, helper) {
	component.set('v.teamColumns',[
		    {label: 'Team', fieldName: 'Name', type: 'text'},
		    {label: 'W', fieldName: 'W__c', type: 'number'},
		    {label: 'L', fieldName: 'L__c', type: 'number'},
			{label: 'PCT', fieldName: 'PCT__c', type: 'number'}
		]);
		component.find("divId").getElement().className = "slds-tabs--scoped__item slds-text-title--caps slds-active customClassForTab";
		component.find("divDataId").getElement().className = "slds-tabs--scoped__item slds-text-title--caps slds-active customClassForTab";
	    helper.getDivisionTeamsHelper(component, event, helper);
	}
		    
})