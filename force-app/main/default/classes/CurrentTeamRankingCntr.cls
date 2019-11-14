public class CurrentTeamRankingCntr  {

    @AuraEnabled
	public static List<Account> getConfTeamList(Id recordId) {
	    Account currentTeam = [SELECT Id, Name, Conference__c
		                       FROM Account
							   WHERE Id =: recordId];
		List<Account> allConfTeams = [SELECT Name, Conference__c, Division__c, W__c, L__c, PCT__c
                                   FROM Account
								   WHERE Conference__c =: currentTeam.Conference__c 
								   ORDER BY PCT__C DESC];
        return allConfTeams;
	}

	@AuraEnabled
	public static List<Account> getDivTeamList(Id recordId) {
	    Account currentTeam = [SELECT Id, Name, Conference__c
		                       FROM Account
							   WHERE Id =: recordId];
		List<Account> allDivTeams = [SELECT Name, Conference__c, Division__c, W__c, L__c, PCT__c
                                   FROM Account
								   WHERE Division__c =: currentTeam.Division__c 
								   ORDER BY PCT__C DESC];
        return allDivTeams;
	}

}