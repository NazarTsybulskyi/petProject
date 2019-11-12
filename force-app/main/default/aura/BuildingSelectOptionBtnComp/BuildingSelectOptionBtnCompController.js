({
	doInit : function(component, event, helper) {
        var getProductsListAction = component.get("c.getProductsList");
        getProductsListAction.setParams({
		    "recordId" : component.get("v.recordId")
        });
        getProductsListAction.setCallback(this, function(response){
            if (response.getState() == "SUCCESS"){
                component.set("v.productsList", response.getReturnValue());   
            } else {
			    console.log("Response state: " + response.getState());
			}
        });
        $A.enqueueAction(getProductsListAction);
    },

	handleSelectedProducts: function(component, event, helper) {
        var selectedIDs = [];
		//var productId2CofinanceMap = {};
        var checkvalue = component.find("checkProduct");
         
        if(!Array.isArray(checkvalue)){
            if (checkvalue.get("v.value") == true) {
                selectedIDs.push(checkvalue.get("v.text"));
                //productId2CofinanceMap.set(checkvalue.get("v.text"),  );
            }
        } else {
            for (var i = 0; i < checkvalue.length; i++) {
                if (checkvalue[i].get("v.value") == true) {
                    selectedIDs.push(checkvalue[i].get("v.text"));
                }
            }
        }
		helper.addSelectedBuildingOptions(component, event, selectedIDs);
        console.log('selectedProducts-->>' + selectedIDs);
    }, 

	cancel : function(component, event, helper){
        $A.get('e.force:closeQuickAction').fire();    
    },
	
})