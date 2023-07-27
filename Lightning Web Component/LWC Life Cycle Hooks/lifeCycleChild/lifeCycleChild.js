import { LightningElement } from 'lwc';

export default class LifeCycleChild extends LightningElement {
    constructor(){
        super();
        console.log('Child Constructor Called');
    }

    connectedCallback(){
        console.log('Child Connected Callback Called');
        throw new Error('Loading of child component failed');
    }
    
    renderedCallback(){
        console.log('Child Rendered Callback Called');
    }

    disconnectedCallback(){
        alert('Child Disconnected Callback Called');
    }
}