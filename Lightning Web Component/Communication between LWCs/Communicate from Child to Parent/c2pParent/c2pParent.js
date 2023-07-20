import { LightningElement } from 'lwc';

export default class C2pParent extends LightningElement {
    showModal = false;
    message;
    handleClick(){
        this.showModal = true;
    }

    handleClose(event){
        this.message = event.detail.msg;
        this.showModal = false;
    }
}