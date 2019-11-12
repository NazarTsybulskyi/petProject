import { LightningElement, track, wire, api } from 'lwc';
import getProductsList from '@salesforce/apex/BuildingSelectOptionCntr.getProductsList';
import addBuildingOptionsLwc from '@salesforce/apex/BuildingSelectOptionCntr.addBuildingOptionsLwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Building Type Supported', fieldName: 'Building_type_supported__c', type: 'text' },
    { label: 'Co-finance allowed', fieldName: 'Co_finance_allowed__c', type: 'boolean' },
    {
        label: 'Apply Co-Finance?',
        type: 'button',
        typeAttributes: { iconName: { fieldName: 'coFinanceIcon' }, disabled: { fieldName: 'coFinanceDisabled' } }
    }
];

export default class BuildingOptions extends LightningElement {
    @api recordId;
    @track error;
    @track productsData = [];
    @track columns = columns;
    @track record = {};
    @wire(getProductsList, { buiildingRecId: '$recordId' })
    retrieveProducts({ data, error }) {
        if (data) {
            this.productsData = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.productsData = undefined;
        }
    }

    handleSelected() {
        let buildingId = this.recordId;
        let tableData = this.template.querySelector('lightning-datatable');
        let selectedRows = tableData.getSelectedRows();
        
        addBuildingOptionsLwc({ parentId: buildingId, selectedProducts: selectedRows })

        this.dispatchEvent( new ShowToastEvent({
            title: 'Success!',
            message: 'Building Options were added successfully!',
            variant: 'success'
        }),)

        .catch(error => {
            this.error = error.message;
        })

    }
    

}