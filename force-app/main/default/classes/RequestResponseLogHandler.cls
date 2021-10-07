public class RequestResponseLogHandler {
    private static RequestResponseLogHandler instance;
    private String responseBody;
    private String requestBody;
    private String resourceId;
    private final String mirrorString;
    private DateTime responseDateTime {
        get {
            if (responseDateTime == null) {
                return DateTime.now();
            } else {
                return responseDateTime;
            }
        }
        private set;
    }
    private DateTime requestDateTime {
        get {
            if (requestDateTime == null) {
                return DateTime.now();
            } else {
                return requestDateTime;
            }
        }
        private set;
    }
    
	private RequestResponseLogHandler(String resourceId) {
        this.resourceId = resourceId;
        this.mirrorString = ResponseFactory.MIRROR_STRING;
    }
    private RequestResponseLogHandler(DateTime responseTime, DateTime requestTime) {
        setResponseTime(responseTime);
        setRequestTime(requestTime);
    }
    
    public static RequestResponseLogHandler getInstance(String resourceId) {
        if (instance == null) {
            instance = new RequestResponseLogHandler(resourceId);
        }
        return instance;
    }
    
    public void setResponseTime(DateTime responseTime) {
        this.responseDateTime = responseTime;
    }
    public void setRequestTime(DateTime requestTime) {
        this.requestDateTime = requestTime;
    }
    public void setRequestBody(String responseBody) {
    	this.responseBody = responseBody;
    }
    public void setResponseBody(String  requestBody) {
    	this.requestBody = requestBody;
    }
    public Response_Log__c log() {
        Response_Log__c logRecord;
        if (this.resourceId != null && !this.resourceId.equals(mirrorString)) {
            logRecord = new Response_Log__c(
                Request_Body__c = this.requestBody,
                Response_Body__c = this.responseBody,
                Response_Configuration__c = (Id)this.resourceId
            );
        }
		return logRecord;
    }
}