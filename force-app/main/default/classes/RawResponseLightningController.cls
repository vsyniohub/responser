public with sharing class RawResponseLightningController {
    public RawResponseLightningController() {

    }

    /* *********************************************
    ** Method Name: getResponseConfiguration
    ** Description: Returns Response Configuration and Raw Response
    ** Parameters: Id
    ** Returns: Response_Configuration__c
    ** ********************************************* */   
    @AuraEnabled(cacheable=true)
    public static Response_Configuration__c getResponseConfiguration(Id recordId) {
        return ResponseUtility.getResponseConfigurationById(recordId);
    }

    /* *********************************************
    ** Method Name: updateConfiguration
    ** Description: 
    ** Parameters: record
    ** Returns: void
    ** ********************************************* */   
    @AuraEnabled
    public static void updateConfiguration(sObject record) {
        ResponseUtility.updateConfiguration(record);
    }
}