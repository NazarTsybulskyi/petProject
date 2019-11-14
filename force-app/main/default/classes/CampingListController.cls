public class CampingListController {

    @AuraEnabled
    public static List<Camping_Item__c> getItems (){
          return [SELECT Id, Name, Price__c, Quantity__c, Packed__c
                 FROM Camping_Item__c];  
    }

    @AuraEnabled
    public static Camping_Item__c createItem(Camping_Item__c campingItem){
        upsert campingItem
        return campingItem;
    }
}