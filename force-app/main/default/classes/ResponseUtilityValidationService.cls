public with sharing class ResponseUtilityValidationService extends Validator {
    private String code;
    private Response_Configuration__c configuration;

    public ResponseUtilityValidationService(sObject validatedObject) {
        this.configuration = (Response_Configuration__c)validatedObject;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public override void validate() {
        checkMinimumValidity();
    }
    public override void checkMinimumValidity() {
        validateCode();
    }
    private void validateCode() {
        if (this.configuration.Configuration_Code__c != null && !this.configuration.Configuration_Code__c.equals(this.code)) {
            throw new AuraHandledException(ConstantVariablesUtility.CODE_DOESNOTMATCH_STRING_VAL);
        }
    }
}
