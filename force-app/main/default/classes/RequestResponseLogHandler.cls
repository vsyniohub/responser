public class RequestResponseLogHandler {
    private static RequestResponseLogHandler instance;
    private String responseBody;
    private String requestBody;
    private String resourceId;
    private Set<String> excludedSubFolders = new Set<String>{ResponseFactory.MIRROR_STRING, ResponseFactory.MIRROR_HEADERS_STRING};
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
    
    /* *********************************************
    ** Method Name: RequestResponseLogHandler
    ** Description: 
    ** Parameters: 
    ** Returns: 
    ** ********************************************* */   
    private RequestResponseLogHandler(String resourceId) {
        this.resourceId = resourceId;
    }
    /* *********************************************
    ** Method Name: RequestResponseLogHandler
    ** Description: 
    ** Parameters: 
    ** Returns: 
    ** ********************************************* */   
    private RequestResponseLogHandler(DateTime responseTime, DateTime requestTime) {
        setResponseTime(responseTime);
        setRequestTime(requestTime);
    }
    
    /* *********************************************
    ** Method Name: getInstance
    ** Description: 
    ** Parameters: 
    ** Returns: 
    ** ********************************************* */   
    public static RequestResponseLogHandler getInstance(String resourceId) {
        if (instance == null) {
            instance = new RequestResponseLogHandler(resourceId);
        }
        return instance;
    }

    /* *********************************************
    ** Method Name: setResponseTime
    ** Description: sets instance variable
    ** Parameters: 
    ** Returns: 
    ** ********************************************* */   
    public void setResponseTime(DateTime responseTime) {
        this.responseDateTime = responseTime;
    }
    /* *********************************************
    ** Method Name: setRequestTime
    ** Description: sets instance variable
    ** Parameters: 
    ** Returns: 
    ** ********************************************* */   
    public void setRequestTime(DateTime requestTime) {
        this.requestDateTime = requestTime;
    }
    /* *********************************************
    ** Method Name: setRequestBody
    ** Description: sets instance variable
    ** Parameters: 
    ** Returns: 
    ** ********************************************* */   
    public void setRequestBody(String responseBody) {
    	this.responseBody = responseBody;
    }
    /* *********************************************
    ** Method Name: setResponseBody
    ** Description: sets isntance variable
    ** Parameters: 
    ** Returns: 
    ** ********************************************* */   
    public void setResponseBody(String requestBody) {
    	this.requestBody = requestBody;
    }
    /* *********************************************
    ** Method Name: log
    ** Description: creates new instance of Response Log record before DML
    ** Parameters: 
    ** Returns: Response_Log__c
    ** ********************************************* */   
    public Response_Log__c log() {
        Response_Log__c logRecord;
        if (this.resourceId != null && !excludedSubFolders.contains(this.resourceId)) {
            logRecord = new Response_Log__c(
                Request_Body__c = this.requestBody,
                Response_Body__c = this.responseBody,
                Response_Configuration__c = (Id)this.resourceId
            );
        }
		return logRecord;
    }
}