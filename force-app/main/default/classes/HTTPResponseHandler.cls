public class HTTPResponseHandler {
    private final String CHAR_SLASH_CHAR = '/';
    private final String CONTENT_TYPE_STRING = 'Content-Type';
    private final String CONTENT_TYPE_STRING_VAL = 'application/json;charset=utf-8';
    
    private String fullURI;
    private String resourceId;
    private RestResponse response;
    
    public HTTPResponseHandler() {
        fullURI 	= RestContext.request.requestURI;
        resourceId 	= fullURI.substringAfterLast(CHAR_SLASH_CHAR);
        response 	= RestContext.response;
    }
    public void processCallin() {
        HTTPResponseCodeHandler responseCodeHandler = HTTPResponseCodeHandler.getInstance();
        AbstractResponser responser = new ResponseFactory().getResponseByType(resourceId);
        
        setContentType();
        setBody(responser.main());
        setCode(responseCodeHandler.getHttpResponseCode());
    }
    private void setBody(String responseBody) {
        response.responseBody = Blob.valueOf(responseBody.replace('&quot;', '"'));
    }
    private void setContentType() {
        response.addHeader(CONTENT_TYPE_STRING, CONTENT_TYPE_STRING_VAL);
    }
    private void setCode(Integer code) {
        response.statusCode = 200;
    }
}