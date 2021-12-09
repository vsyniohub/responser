import { LightningElement, wire,api, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import ID_FIELD from '@salesforce/schema/Response_Configuration__c.Id';
import RAWRESPONSE_FIELD from '@salesforce/schema/Response_Configuration__c.Raw_Response__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getResponseConfiguration from '@salesforce/apex/RawResponseLightningController.getResponseConfiguration';
import updateConfiguration from '@salesforce/apex/RawResponseLightningController.updateConfiguration';

export default class JsonContainer extends LightningElement {
    @api recordId;
    @api pureLightning;
    @api objectApiName;// = 'Response_Configuration__c';
    @track responseText;
    @track shownCustomToast = true;
    @track isSelected = false;

    record;

    connectedCallback() {
        getResponseConfiguration({recordId : this.recordId })
        .then(result => {
            this.responseText = result.Raw_Response__c;
            this.record = result;
        })
        .catch(error => {
            this.showToast('Error', error.body.message, 'error');
        });
    }
    
    saveData(event) {
        const inputRecord = {
            sObjectType : 'Response_Configuration__c',
            Id : this.record.Id, 
            Raw_Response__c : this.responseText
        }
        updateConfiguration({record : inputRecord})
        .then(() => {
            console.log('before update');
            this.isSelected = false;
            this.showToast('Success', 'Successful record update', 'success');
            //this.template.querySelector('c-toast-message').showMessage('success', 'Successful record update');
        })
        .catch(error => {
            console.log('error ' + error.body.message);
            this.isSelected = true;
            this.showToast('Error', error.body.message, 'error');
            //this.template.querySelector('c-toast-message').showMessage('error', error.body.message);
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
        if (this.pureLightning) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: titleText,
                    message: messageText,
                    variant: messageType
                })
            );
        }
    }
}