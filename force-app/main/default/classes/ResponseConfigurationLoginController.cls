public with sharing class ResponseConfigurationLoginController {

    /* *********************************************
    ** Method Name: getResponseConfiguration
    ** Description: Returns Response Configuration
    ** Parameters: Id
    ** Returns: Response_Configuration__c
    ** ********************************************* */   
    @AuraEnabled(cacheable=true)
    public static Response_Configuration__c getResponseConfiguration(Id recordId) {
        return ResponseUtility.getResponseConfigurationById(recordId);
    }
}
