import { LightningElement } from 'lwc';

export default class LifeCycleParent extends LightningElement {
    showChild = false;
    constructor(){
        super();
        console.log('Parent Constructor Called');
    }

    connectedCallback(){
        console.log('Parent Connected Callback Called');
    }
    
    renderedCallback(){
        console.log('Parent Rendered Callback Called');
    }

    handleClick(){
        this.showChild = !this.showChild;
    }

    errorCallback(error, stack){
        console.log(error.message);
        console.log(stack);
    }
}