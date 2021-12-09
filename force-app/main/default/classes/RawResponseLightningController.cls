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
    ** Method Name: getResponseConfiguration
    ** Description: Returns Response Configuration
    ** Parameters: recordId, recordCode
    ** Returns: Response_Configuration__c
    ** ********************************************* */   
    @AuraEnabled(cacheable=true)
    public static void updateConfiguration(Response_Configuration__c record) {
        ResponseUtility.updateConfiguration(record);
    }
}