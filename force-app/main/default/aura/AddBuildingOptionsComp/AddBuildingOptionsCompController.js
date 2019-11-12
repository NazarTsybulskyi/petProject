({
	init : function(component, event, helper) {
	    component.set('v.productColumns',[
		    {label: 'Product Name', fieldName: 'Name', type: 'text'},
		    {label: 'Building Type Supported', fieldName: 'Building_type_supported__c', type: 'text'},
		    {label: 'Co-finance allowed', fieldName: 'Co_finance_allowed__c', type: 'boolean'},
			{label: 'Apply co-finance?', type:'button', typeAttributes: 
			                            { iconName:{fieldName: 'coFinanceIcon'}, disabled:{fieldName: 'coFinanceDisabled'}}}
		]);
	    helper.getProductsListHelper(component, event, helper);
	},
	
	handleSelectedProducts : function(component, event, helper) {
	    console.log('--->>> inside handleSelectedProducts');
	    var selectedProducts = component.find('productsTable').getSelectedRows();
		var selectedIdToCoFinance = [];
		for (var i = 0; i < selectedProducts.length; i++) {
			selectedIdToCoFinance.push({productId:selectedProducts[i].Id, coFinanceSelected:selectedProducts[i].coFinanceSelected});
		}
		console.log('selectedIdToCoFinance.size == ' + selectedIdToCoFinance.length);
		var selectedIdToCoFinanceMap = selectedIdToCoFinance.map(item =>{
		    var container = {};
			container.Id = item.Id;
			container.coFinanceSelected = item.coFinanceSelected;
			return container;
		})
	    helper.addBuildingOptionsHelper(component, event, selectedIdToCoFinance);
	},

	handleRowAction : function(component, event, helper) {
	    var data = component.get('v.products');
		var row = event.getParam('row');
		data = data.map(function (rowData) {
		    if (rowData.Id === row.Id) {
		        if (rowData.coFinanceSelected) {
		            rowData.coFinanceSelected = false;
			        rowData.coFinanceIcon = 'utility:add';
		        } else {
		            rowData.coFinanceSelected = true;
			        rowData.coFinanceIcon = 'utility:check';
		        }
			
		    }
            return rowData;
		});
		component.set('v.products', data);	
		console.log('--->>> select clicked');
							
	},

	cancel : function(component, event, helper) {
        $A.get('e.force:closeQuickAction').fire();    
    }

});