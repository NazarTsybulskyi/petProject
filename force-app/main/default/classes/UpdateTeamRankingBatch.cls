global class UpdateTeamRankingBatch implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String queryString = 'SELECT Name, Conference__c, Division__c, W__c, L__c, PCT__c, ' + 
		                     'Current_Conference_Position__c, Current_Division_Position__c ' +
                             'FROM Account' +
                             'WHERE RecordType.DeveloperName = \'Team\'';
        return Database.getQueryLocator(queryString);
    }

    public void execute(Database.BatchableContext bc, List<sObject> scope) {

    }   

    public void finish(Database.BatchableContext bc) {

    } 
}