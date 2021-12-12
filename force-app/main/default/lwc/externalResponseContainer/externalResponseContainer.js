import { LightningElement, api } from 'lwc';

export default class ExternalResponseContainer extends LightningElement {
    @api recordId;
    connectedCallback() {
        console.log('Connected ' + this.recordId);
    }
}