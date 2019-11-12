@isTest
public class BuildingSelectOptionCntrTest  {
    
	@isTest
	static void testGetProductsList() {
	    List<Building__c> bRecords = TestDataFactory.createBuildings(1);
		insert bRecords;

		List<Product2> p2Records = TestDataFactory.createProducts2(5);
		p2Records.get(0).Building_type_supported__c = 'A;B'; 
		p2Records.get(1).Building_type_supported__c = 'A'; 
		p2Records.get(2).Building_type_supported__c = 'B;C;D'; 
		p2Records.get(3).Building_type_supported__c = 'A;D'; 
		p2Records.get(4).Building_type_supported__c = 'B;C'; 
		insert p2Records;

		Building__c currentBuilding = [SELECT Id, Type__c FROM Building__c LIMIT 1];
		Test.startTest(); 
		List<Product2> filteredProductList = BuildingSelectOptionCntr.getProductsList(currentBuilding.Id);
		Test.stopTest();
		System.assert(filteredProductList.get(1).Building_type_supported__c.contains(currentBuilding.Type__c));
	}

	@isTest
	static void testAddBuildingOptions() {
	    List<Building__c> bRecords = TestDataFactory.createBuildings(1);
		bRecords.get(0).Type__c = 'A';
		insert bRecords;

		List<Product2> p2Records = TestDataFactory.createProducts2(5);
		p2Records.get(0).Building_type_supported__c = 'A;B'; 
		p2Records.get(1).Building_type_supported__c = 'A'; 
		p2Records.get(2).Building_type_supported__c = 'B;C;D'; 
		p2Records.get(3).Building_type_supported__c = 'A;D'; 
		p2Records.get(4).Building_type_supported__c = 'B;C'; 
		insert p2Records;

		Building__c currentBuilding = [SELECT Id, Type__c FROM Building__c LIMIT 1]; 
		List<Product2> filteredProductList = BuildingSelectOptionCntr.getProductsList(currentBuilding.Id);
		List<Id> filteredProductsIDs = new List<Id>();
		for (Product2 pRecord : filteredProductList) {
		    filteredProductsIDs.add(pRecord.Id);
		}

		Test.startTest();
		BuildingSelectOptionCntr.addBuildingOptions(currentBuilding.Id, filteredProductsIDs);
	    Test.stopTest();

		List<Building_Option__c> testBuildOptionsList = [SELECT Id, Name, Product2__c, Building__c
		                                                 FROM Building_Option__c];
		System.assertEquals(3, testBuildOptionsList.size());
		System.assertEquals(currentBuilding.Id, testBuildOptionsList.get(2).Building__c);

	}

}