public without sharing class ResponseUtility {
    private static DMLHandler databaseHandler;

    /* *********************************************
    ** Method Name: returnResponseConfiguration
    ** Description: Returns Response Configuration
    ** Parameters: recordId, recordCode
    ** Returns: Response_Configuration__c
    ** ********************************************* */   
    public static Response_Configuration__c returnResponseConfiguration(Id recordId, String recordCode) {
        Response_Configuration__c configuration = getResponseConfigurationById(recordId);

        ResponseUtilityValidationService validation = new ResponseUtilityValidationService(configuration);
        validation.setCode(recordCode);
        validation.validate();

        return configuration;
    }
    /* *********************************************
    ** Method Name: getResponseConfigurationById
    ** Description: Returns Response Configuration
    ** Parameters: recordId, recordCode
    ** Returns: Response_Configuration__c
    ** ********************************************* */   
    public static Response_Configuration__c getResponseConfigurationById(Id recordId) {
        try {
            return [
                SELECT Id, Configuration_Code__c, Raw_Response__c
                FROM Response_Configuration__c
                WHERE Id = :recordId
            ];
        } catch (Exception e) {
            String errorMessage = e.getMessage();
            throw new AuraHandledException(errorMessage);
        }
    }

    /* *********************************************
    ** Method Name: updateConfiguration
    ** Description: 
    ** Parameters: record
    ** Returns: void
    ** ********************************************* */   
    public static void updateConfiguration(Response_Configuration__c record) {
        databaseHandler = DMLHandler.getInstance(); //handles database operations
        try {
            databaseHandler.addDirty(record);
        } catch (Exception e) {
            String errorMessage = e.getMessage();
            throw new AuraHandledException(errorMessage);
        } finally {
            databaseHandler.commitWork();
        }
    }
}
