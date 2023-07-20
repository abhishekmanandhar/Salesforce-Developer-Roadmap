import { LightningElement } from 'lwc';

export default class C2pChild extends LightningElement {
    handleClick(){
        const event = new CustomEvent('close', {
            detail: {
                msg: "Event Closed Successfully!"
            } 
        });
        this.dispatchEvent(event);
    }
}