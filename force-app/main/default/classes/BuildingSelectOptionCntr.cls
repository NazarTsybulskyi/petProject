public class BuildingSelectOptionCntr {
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> getProductsList(Id buiildingRecId) {
	    Building__c currentBuilding = [SELECT Name, Type__c
		                               FROM Building__c
								       WHERE Id =: buiildingRecId];
		String currentBuildingType = currentBuilding.Type__c;
        List<Product2> productsList = [SELECT Name, Building_type_supported__c, Co_finance_allowed__c
		                              FROM Product2
		                              WHERE Building_type_supported__c INCLUDES (:currentBuildingType)];
		return productsList;
    }

	@AuraEnabled(cacheable=true)
	public static void addBuildingOptions(String parentId, String selectedProducts) {

	    System.debug('selectedProducts parameter = ' + selectedProducts);

		Building__c parentBuilding = [SELECT Name, Type__c FROM Building__c
		                             WHERE Id =: parentId];

	    List<JSON2Apex> selectedList = JSON2Apex.parse(selectedProducts);
		List<Building_Option__c> buildingOptionsList = new List<Building_Option__c>();

		for(JSON2Apex jsonItem : selectedList) {
		    buildingOptionsList.add(new Building_Option__c(
			                        Name =  parentBuilding.Name + '_' + jsonItem.productId,
									Product2__c = jsonItem.productId,
									Building__c = parentId,
									Cofinance__c = jsonItem.coFinanceSelected
									));									 
		}
		System.debug('list to insert = ' + buildingOptionsList);
		insert buildingOptionsList;
	}
	
	@AuraEnabled
	public static void addBuildingOptionsLwc(String parentId, List<Product2> selectedProducts) {

		Building__c parentBuilding = [SELECT Name, Type__c FROM Building__c
		                             WHERE Id =: parentId];
		List<Building_Option__c> buildingOptionsList = new List<Building_Option__c>();

		for (Product2 prodRecord : selectedProducts) {
		    buildingOptionsList.add(new Building_Option__c(
			                        Name =  parentBuilding.Name + '_' + prodRecord.Id,
									Product2__c = prodRecord.Id,
									Building__c = parentId
									//Cofinance__c = prodRecord.coFinanceSelected
									));									 
		}
		System.debug('list to insert = ' + buildingOptionsList);
		insert buildingOptionsList;
	}
  
}