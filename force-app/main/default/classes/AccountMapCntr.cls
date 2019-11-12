public class AccountMapCntr {

    @AuraEnabled
    public static List<Location> getAllAccountLocations(){
        List<Account> allTeamAccounts = [SELECT Name, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry
                                        FROM Account
                                        WHERE RecordType.DeveloperName = 'Team'];
        List<Location> allAccountLocations = new List<Location>();
        for (Account aRecord : allTeamAccounts) {
            GeoLocation geoLocAccDetails = new GeoLocation();
            geoLocAccDetails.City = aRecord.ShippingCity;
            geoLocAccDetails.Street = aRecord.ShippingStreet;
            geoLocAccDetails.State = aRecord.ShippingState;
            geoLocAccDetails.PostalCode = aRecord.ShippingPostalCode;
            geoLocAccDetails.Country = aRecord.ShippingCountry;
            Location locDetails = new Location();
            locDetails.icon = 'utility:activity';
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

        //add latitude/longitude to avoid limits and show all markers at a time
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