public class LeadServices {

   @TestVisible static final ID PROSPECT_RT_ID = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get('Prospect').getRecordTypeId();
    @TestVisible static final Double CM_TO_FEET = 30.48;
	@TestVisible static final Double CM_TO_INCH = 2.54;
	@TestVisible static final Double KG_TO_LBS = 0.453592;

    public static void updateLastActivityInfo(Map<Task, Id> entryMap) {
        Map<Id, Lead> leadsByIdMap = new Map<Id, Lead> (
                                                                [SELECT LA_Comments__c, LA_Date__c, LA_Subject__c
                                                                FROM Lead
                                                                WHERE Id IN : entryMap.values()]);

        Map<Id, Lead> leadsToUpdateById = new Map<Id, Lead> ();
        for (Task tRecord : entryMap.keySet()) {
            Id leadId = entryMap.get(tRecord);
            Lead tmpLead = leadsByIdMap.get(leadId);
            tmpLead.LA_Comments__c = tRecord.Description;
            tmpLead.LA_Date__c = tRecord.Date_of_Activity__c;
            tmpLead.LA_Subject__c = tRecord.Subject;
            leadsToUpdateById.put(tRecord.Id, tmpLead);
        }

        if (!leadsToUpdateById.values().isEmpty()) {

            update leadsToUpdateById.values();
        }
    }

    	/**
	* @description a method used to update players data from US to metric system
	* @param entryList list of Leads to update
	*/ 
	public static void updateMetrics(List<Lead> entryList) {
	    for (Lead record :entryList) {
		    //separate the values of feet and inches for Height
			String[] heightArr = record.Height_f_in__c.split('\'');
			Integer heightValue = (Integer)Math.round(Integer.valueOf(heightArr[0])*CM_TO_FEET + Integer.valueOf(heightArr[1])*CM_TO_INCH);
			//separate the values of feet and inches for Wingspan
			String[] wingspanArr = record.Wingspan_f_in__c.split('\'');
			Integer wingspanValue = (Integer)Math.round(Integer.valueOf(wingspanArr[0])*CM_TO_FEET + Integer.valueOf(wingspanArr[1])*CM_TO_INCH);

			Integer weightInKg = (Integer)Math.round(record.Weight_lbs__c*KG_TO_LBS);

			record.Height_cm__c = heightValue;
			record.Wingspan_cm__c = wingspanValue;
			record.Weight_kg__c = weightInKg;
		}
		//update entryList;
	}
}