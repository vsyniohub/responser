public with sharing class ResponseConfigurationLoginController {

    /* *********************************************
    ** Method Name: getResponseConfiguration
    ** Description: Returns Response Configuration
    ** Parameters: recordId, recordCode
    ** Returns: Response_Configuration__c
    ** ********************************************* */   
    @AuraEnabled(cacheable=true)
    public static Response_Configuration__c getResponseConfiguration(Id recordId, String recordCode) {
        return ResponseUtility.returnResponseConfiguration(recordId, recordCode);
    }
}