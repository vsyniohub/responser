import { LightningElement, wire,api, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from '@salesforce/schema/Response_Configuration__c.Id';
import RAWRESPONSE_FIELD from '@salesforce/schema/Response_Configuration__c.Raw_Response__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getResponseConfiguration from '@salesforce/apex/RawResponseLightningController.getResponseConfiguration';

export default class JsonContainer extends LightningElement {
    @api recordId;
    @api objectApiName;// = 'Response_Configuration__c';
    @track responseText;
    @track isSelected = false;

    connectedCallback() {
        getResponseConfiguration({recordId : this.recordId })
        .then(result => {
            this.responseText = result.Raw_Response__c;
        })
        .catch(error => {
            this.showToast('Error', error.body.message, 'error');
        });
    }
    
    saveData(event) {
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId;
        fields[RAWRESPONSE_FIELD.fieldApiName] = this.responseText;
        const recordInput = { fields };
        updateRecord(recordInput)
            .then(() => {
                console.log('before update');
                this.isSelected = false;
                this.showToast('Success', 'Successful record updae', 'success');
            })
            .catch(error => {
                this.isSelected = true;
                this.showToast('Error', error.body.message, 'error');
            });
    }
    textAreaChange(event) {
        this.responseText = event.target.value;
        this.isSelected = true;
    }
    handlePretty(event) {
        this.isSelected = true;
        this.responseText = '' + JSON.stringify(
            JSON.parse(this.responseText),
            null, 
            '\t'
        );
        console.log(this.responseText);
    }
    showToast(titleText, messageText, messageType) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: titleText,
                message: messageText,
                variant: messageType
            })
        );
    }
}