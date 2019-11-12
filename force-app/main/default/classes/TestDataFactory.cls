@isTest 
public class TestDataFactory {

	public static List<Building__c> createBuildings(Integer numOfRecords) {
	    List<Building__c> buildingsList = new List<Building__c>();
		List<String> buildingTypeValues = new List<String> {'A','B','C','D'};
		for (Integer i = 0; i < numOfRecords; i++) {
		    buildingsList.add(new Building__c(
			                      Name = 'Building-' + i,
								  Type__c = buildingTypeValues.get((Integer)(Math.random()*4)) 
							  ));
		    }
		return buildingsList;
	}

	public static List<Product2> createProducts2(Integer numOfRecords) {
	    List<Product2> productsList = new List<Product2>();
		for (Integer i = 0; i < numOfRecords; i++) {
		    productsList.add(new Product2(
			                     Name = 'Product-' + i,
								 Co_finance_allowed__c = (Math.mod(i,2)==0) ? true : false,
								 IsActive = true
						    ));
		}
		return productsList;
	}

}