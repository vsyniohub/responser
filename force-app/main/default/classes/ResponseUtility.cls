public without sharing class ResponseUtility {
    public static Response_Configuration__c getResponseConfigurationById(Id recordId) {
    return [
            SELECT Id, Configuration_Code__c, Raw_Response__c
            FROM Response_Configuration__c
            WHERE Id = :recordId
        ];
    }
}
