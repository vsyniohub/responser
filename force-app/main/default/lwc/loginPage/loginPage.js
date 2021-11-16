import { LightningElement } from 'lwc';
import getResponseConfiguration from '@salesforce/apex/ResponseConfigurationLoginController.getResponseConfiguration';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LoginPage extends LightningElement {
    responseId;
    idValue;
    hasError = false;
    errorMessage = 'More value';
    codeValue;

    connectedCallback() {
        console.log(location.search);
        
    }
    setIdField(event) {
        this.idValue = event.target.value;
        console.log(this.idValue);
    }
    setCodeField(event) {
        this.codeValue = event.target.value;
        console.log(this.codeValue);
    }
    handleOpenConfiguration(event) {
        console.log(this.idValue);
        if (this.validateId()) {
            this.retrieveResponseConfiguration();
        } else {
            console.log('Validity');
        }
    }

    validateId() {
        return (this.idValue ? true : false)
    }
    setValidityError() {

    }
    retrieveResponseConfiguration() {
        console.log('Entered retrieve');
        getResponseConfiguration({recordId : this.idValue })
        .then(result => {
            console.log('Entered retrieve result');
            
        })
        .catch(error => {
            console.log('Entered retrieve error ' + error.body.message);
            
        });
    }
}