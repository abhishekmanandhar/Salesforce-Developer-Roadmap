import { LightningElement } from 'lwc';
import signinTemplate from './signinTemplate.html';
import signupTemplate from './signupTemplate.html';
import renderTempalte from './renderMethod.html';

export default class RenderMethod extends LightningElement {
    selectedBtn = '';
    render(){
        return this.selectedBtn === 'Signup' ? signupTemplate : this.selectedBtn === 'Signin' ? signinTemplate : renderTempalte;
    }

    handleClick(event){
        this.selectedBtn = event.target.label;
    }

    submitHandler(event){
        console.log(`${event.target.label} was successful`);
    }
}