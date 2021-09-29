public class HTTPResponseHandler {
    private final String CHAR_SLASH_CHAR = '/';
    private final String CONTENT_TYPE_STRING = 'Content-Type';
    private final String CONTENT_TYPE_STRING_VAL = 'application/json;charset=utf-8';
    
    private String fullURI;
    private String resourceId;
    private RestResponse response;

    /* *********************************************
    ** Method Name: HTTPResponseHanler
    ** Parameters: no
    ** Returns: void
    ** ********************************************* */
    private RequestResponseLogHandler logHandler;
    private DMLHandler databaseHandler;
    public HTTPResponseHandler() {
        fullURI 	= RestContext.request.requestURI;
        resourceId 	= fullURI.substringAfterLast(CHAR_SLASH_CHAR);
        response 	= RestContext.response;
    }

    /* *********************************************
    ** Method Name: processCallin
    ** Parameters: no
    ** Returns: void
    ** Description: main method to initialize handlers
    ** ********************************************* */
    public void processCallin() {
        logHandler 		= RequestResponseLogHandler.getInstance(resourceId); //logs requests and responses
        databaseHandler = DMLHandler.getInstance(); //handles database operations
        
        HTTPResponseCodeHandler responseCodeHandler = HTTPResponseCodeHandler.getInstance(); //handles HTTP Codes
        
        AbstractResponser responser = new ResponseFactory().getResponseByType(resourceId); //returns response from configuration
        String responseText = responser.main();
        
        setContentType();
        setBody(responseText);
        setCode(responseCodeHandler.getHttpResponseCode());
        
        logHandler.setResponseBody(responseText);
        databaseHandler.addNew(logHandler.log());
		databaseHandler.commitWork();
    }

    /* *********************************************
    ** Method Name: setBody
    ** Parameters: String
    ** Returns: void
    ** Description: sets RestResponse body
    ** ********************************************* */
    private void setBody(String responseBody) {
        response.responseBody = Blob.valueOf(responseBody.replace('&quot;', '"'));
    }

    /* *********************************************
    ** Method Name: setContentType
    ** Parameters: no
    ** Returns: void
    ** Description: sets HTTP Content Type
    ** ********************************************* */
    private void setContentType() {
        response.addHeader(CONTENT_TYPE_STRING, CONTENT_TYPE_STRING_VAL);
    }

    /* *********************************************
    ** Method Name: setCode
    ** Parameters: no
    ** Returns: void
    ** Description: sets HTTP Response Code
    ** ********************************************* */
    private void setCode(Integer code) {
        response.statusCode = 200;
    }
}