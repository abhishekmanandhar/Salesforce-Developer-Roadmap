import { LightningElement, api } from 'lwc';

export default class P2cChild extends LightningElement {
    @api name;
    @api title;
    @api number;
    @api isValid;
    @api carousalDetails;
}