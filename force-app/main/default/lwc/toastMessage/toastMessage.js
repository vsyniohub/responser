import { LightningElement, track, api } from 'lwc';

export default class ToastMessage extends LightningElement {
    @track showToast = false;
    @track message = 'Empty message';
    @track type = 'warning';
    @api showMessage(type, message) {
        console.log('Inside the toast');
        this.message = message;
        this.type = type;
        this.showToast = true;
    }
}