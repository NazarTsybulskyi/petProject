trigger TaskTrigger on Task(before insert, before update, before delete,
                            after insert, after update, after delete, after undelete) {

	if (Trigger.isAfter) {
		if (Trigger.isInsert) {
			Map<Task, Id> taskToLeadIdMap = new Map<Task, Id> ();

			for (Task tRecord : Trigger.new) {
				if (((String) tRecord.WhoId).startsWith('00Q')) {
					taskToLeadIdMap.put(tRecord, tRecord.WhoId);
				}
			}
			if (taskToLeadIdMap.size() > 0) {
				LeadServices.updateLastActivityInfo(taskToLeadIdMap);
			}
		}
	}

}