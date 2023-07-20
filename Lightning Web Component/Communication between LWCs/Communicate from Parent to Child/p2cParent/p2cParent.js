import { LightningElement } from 'lwc';

export default class P2cParent extends LightningElement {
    name = "Abhishek Manandhar";
    title = "Parent to Child";
    number = 1234567890;
    isValid = true;

    carousalDetails = [
        {
            src:"https://imgv3.fotor.com/images/cover-photo-image/a-beautiful-girl-with-gray-hair-and-lucxy-neckless-generated-by-Fotor-AI.jpg",
            header:"First card",
            description:"First card description"
        },
        {
            src:"path/to/carousel-02.jpg",
            header:"Second card",
            description:"Second card description"
        },
        {
            src:"path/to/carousel-03.jpg",
            header:"Third card",
            description:"Third card description"
        }
    ]

    progressValue = 10;

    handleChange(event){
        this.progressValue = event.target.value;
    }
}