global class UpdateTeamRankingBatch implements Database.Batchable<sObject>, Schedulable {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String rtName = 'Team';
        String queryString = 'SELECT Name,RecordType.Name, Conference__c, Division__c, W__c, L__c, PCT__c, ' + 
		                     'Current_Conference_Position__c, Current_Division_Position__c ' +
                             'FROM Account ' +
                             'WHERE RecordType.Name =: rtName ' +
                             'ORDER BY PCT__c DESC';
        return Database.getQueryLocator(queryString);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        List<Account> westConfTeams = new List<Account>();
        List<Account> eastConfTeams = new LIst<Account>();
        for (Account aRecord : scope) {
            if (aRecord.Conference__c == 'West') {
                westConfTeams.add(aRecord);
            } else {
                eastConfTeams.add(aRecord);
            }
        }
        for (integer i = 0; i < eastConfTeams.size(); i++) {
            eastConfTeams[i].Current_Conference_Position__c = i+1;
        }
        for (integer i = 0; i < westConfTeams.size(); i++) {
            westConfTeams[i].Current_Conference_Position__c = i+1;
        }
        update eastConfTeams;
        update westConfTeams;      

    }
        public void finish(Database.BatchableContext bc) {

    } 

        public void execute(SchedulableContext sc) {

        }
}