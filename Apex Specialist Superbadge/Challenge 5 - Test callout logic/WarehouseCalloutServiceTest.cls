@isTest
public with sharing class WarehouseCalloutServiceTest {
    @isTest static void testWarehouseCalloutService(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
        System.assertEquals(1, [SELECT count() FROM Product2], 'Error: No Equipments found!');
    }
}