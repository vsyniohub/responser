public class HTTPResponseHandler {
    public final static String GET_STRING = 'GET';
    public final static String POST_STRING = 'POST';
    
    private final String CHAR_SLASH_CHAR = '/';
    private final String CONTENT_TYPE_STRING = 'Content-Type';
    private final String CONTENT_TYPE_STRING_VAL = 'application/json;charset=utf-8';
    
    private String fullURI;
    private String resourceId;
    private String method;
    private RestResponse response;

    /* *********************************************
    ** Method Name: HTTPResponseHanler
    ** Parameters: no
    ** Returns: void
    ** ********************************************* */
    private RequestResponseLogHandler logHandler;
    private DMLHandler databaseHandler;

    /* *********************************************
    ** Method Name: HTTPResponseHandler
    ** Description: Constructor
    ** Parameters: String
    ** Returns: N/A
    ** ********************************************* */    
    public HTTPResponseHandler(String method) {
        this.method		= method;
        this.fullURI 	= RestContext.request.requestURI;
        this.resourceId = fullURI.substringAfterLast(CHAR_SLASH_CHAR);
        this.response 	= RestContext.response;
    }

    /* *********************************************
    ** Method Name: processCallin
    ** Description: Runs main part of a handler
    ** Parameters: no
    ** Returns: void
    ** ********************************************* */   
    public void processCallin() {
        logHandler 		= RequestResponseLogHandler.getInstance(resourceId); //logs requests and responses
        databaseHandler = DMLHandler.getInstance(); //handles database operations
        
        AbstractResponser responser = new ResponseFactory().getResponseByType(resourceId); //returns response from configuration
        String responseText = responser.main();
        
        HTTPResponseCodeHandler responseCodeHandler = HTTPResponseCodeHandler.getInstance(); //handles HTTP Codes
        
        setContentType();
        setBody(responseText);
        setCode(responseCodeHandler.getHttpResponseCode());
        
        logHandler.setResponseBody(responseText);
        databaseHandler.addNew(logHandler.log());
        
        databaseHandler.commitWork();
    }

    /* *********************************************
    ** Method Name: setBody
    ** Description: sets HTTP Response body
    ** Parameters: String
    ** Returns: void
    ** ********************************************* */   
    private void setBody(String responseBody) {
        response.responseBody = Blob.valueOf(responseBody.replace('&quot;', '"'));
    }

    /* *********************************************
    ** Method Name: setContentType
    ** Description: sets HTTP Content Type
    ** Parameters: no
    ** Returns: void
    ** ********************************************* */   
    private void setContentType() {
        response.addHeader(CONTENT_TYPE_STRING, CONTENT_TYPE_STRING_VAL);
    }

    /* *********************************************
    ** Method Name: setCode
    ** Description: sets default HTTP Response code
    ** Parameters: Integer
    ** Returns: void
    ** ********************************************* */   
    private void setCode(Integer code) {
        response.statusCode = 200;
    }
}