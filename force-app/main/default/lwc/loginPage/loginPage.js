import { LightningElement } from 'lwc';
import getResponseConfiguration from '@salesforce/apex/ResponseConfigurationLoginController.getResponseConfiguration';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LoginPage extends LightningElement {
    responseId;
    idValue;
    hasError = false;
    errorMessage = '';
    codeValue;

    connectedCallback() {
        console.log(location.search);
        
    }
    setIdField(event) {
        this.idValue = event.target.value;
    }
    onIdFocus(event) {
        this.setValidityClear();
    }
    onValueFocus(event) {
        this.setValidityClear();
    }
    setCodeField(event) {
        this.codeValue = event.target.value;
    }
    handleOpenConfiguration(event) {
        if (!this.validateId()) {
            this.setValidityError('Id value is not provided');
        } else if (!this.validateValue()) {
            this.setValidityError('Code value is not provided');
        } else {
            this.retrieveResponseConfiguration();
        }
    }

    validateId() {
        return (this.idValue ? true : false)
    }
    validateValue() {
        return (this.codeValue ? true : false)
    }
    setValidityError(text) {
        this.errorMessage = text;
        this.hasError = true;
    }
    setValidityClear(){
        this.hasError = false;
    }
    setIdValidity(text) {

    }
    retrieveResponseConfiguration() {
        getResponseConfiguration({
            recordId : this.idValue,
            recordCode : this.codeValue
        })
        .then(result => {
            console.log('Entered retrieve result');
            
            this.navigateToPage();
        })
        .catch(error => {
            this.setValidityError(error.body.message);
            console.log('Entered retrieve error ' + error.body.message);
        });
    }
    navigateToPage() {
        this.dispatchEvent(new CustomEvent('redirectTo', {
            detail: { },
            bubbles: true,
            composed: false,
        }));
    }
}