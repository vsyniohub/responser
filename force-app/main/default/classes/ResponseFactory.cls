public class ResponseFactory {
	public static Id RECORDTYPE_CONFIGURABLE 	= Schema.SObjectType.Response_Configuration__c.getRecordTypeInfosByName().get('Configurable').getRecordTypeId();
	public static Id RECORDTYPE_RAW 			= Schema.SObjectType.Response_Configuration__c.getRecordTypeInfosByName().get('Raw').getRecordTypeId();
    
   	public static Response_Configuration__c queryResponseConfiguration(String resourceId) {
        return [SELECT Id, RecordTypeId, Raw_Response__c FROM Response_Configuration__c WHERE Id = :resourceId];    
    }
    
    public AbstractResponser getResponseByType(Id resourceId) {
        Response_Configuration__c configuration = queryResponseConfiguration(resourceId);
        Id responseRecordTypeId = configuration.RecordTypeId;
        
        AbstractResponser responser;
		if (responseRecordTypeId == RECORDTYPE_RAW) {
            responser = new RawResponser(resourceId);
        } else if (responseRecordTypeId == RECORDTYPE_CONFIGURABLE) {
            responser = new ConfiguredResponser(resourceId);
        }
        responser.setResponseConfiguration(configuration);
        
        return responser;
    }
}