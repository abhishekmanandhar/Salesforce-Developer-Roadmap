//The test class uses a mock class called AnimalLocatorMock implementing HttpCalloutMock to mock the callout response
@isTest
public with sharing class AnimalLocatorTest {
    @isTest private static void animalLocatorTest(){
        //Set mock callout class
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String actualName = AnimalLocator.getAnimalNameById(1);
        String expectedName = 'chicken';
        System.assertEquals(actualName, expectedName);
    }
}