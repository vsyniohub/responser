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
        return [
            SELECT Id, Raw_Response__c
            FROM Response_Configuration__c
            WHERE Id = :recordId
        ];
    }
}
