trigger LeadTrigger on Lead(before insert, before update, before delete,
                            after insert, after update, after delete, after undelete) {
	if (Trigger.isBefore) {
		Id prospect_rt_Id = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName()
		.get('Prospect').getRecordTypeId();
		Id business_rt_Id = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName()
		.get('Business_Partner').getRecordTypeId();
		List<Lead> leadsToUpdate = new List<Lead>();
		for (Lead lRecord : Trigger.new) {
		    
		}
		//LeadServices.();

	}


}