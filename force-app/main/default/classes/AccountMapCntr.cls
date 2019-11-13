public class AccountMapCntr {

    @AuraEnabled
    public static List<Location> getAllAccountLocations(){
        List<Account> allTeamAccounts = [SELECT Name, GeoLocation__c, GeoLocation__Latitude__s, GeoLocation__Longitude__s,
                                        ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry
                                        FROM Account
                                        WHERE RecordType.DeveloperName = 'Team'
                                        AND GeoLocation__Latitude__s != null];
        List<Location> allAccountLocations = new List<Location>();
        for (Account aRecord : allTeamAccounts) {
            GeoLocation geoLocAccDetails = new GeoLocation();
            geoLocAccDetails.City = aRecord.ShippingCity;
            geoLocAccDetails.Street = aRecord.ShippingStreet;
            geoLocAccDetails.State = aRecord.ShippingState;
            geoLocAccDetails.PostalCode = aRecord.ShippingPostalCode;
            geoLocAccDetails.Country = aRecord.ShippingCountry;
            geoLocAccDetails.Latitude = aRecord.GeoLocation__Latitude__s;
            geoLocAccDetails.Longitude = aRecord.GeoLocation__Longitude__s;
            Location locDetails = new Location();
            locDetails.icon = 'standard:account';
            locDetails.title = aRecord.Name;
            locDetails.location = geoLocAccDetails;
            allAccountLocations.add(locDetails);
        }
        return allAccountLocations;
    
    }

    public class GeoLocation{
        @AuraEnabled
        public String Street{get;set;}

        @AuraEnabled
        public String City{get;set;}

        @AuraEnabled
        public String State{get;set;}

        @AuraEnabled
        public String PostalCode{get;set;}

        @AuraEnabled
        public String Country{get;set;}

        @AuraEnabled
        public Decimal Latitude{get; set;}
        
        @AuraEnabled
        public Decimal Longitude{get; set;}
        
    }

    public class Location{
        @AuraEnabled
        public String icon{get;set;}

        @AuraEnabled
        public String title{get;set;}

        @AuraEnabled
        public String description{get;set;}

        @AuraEnabled
        public GeoLocation location{get;set;}
    }

}