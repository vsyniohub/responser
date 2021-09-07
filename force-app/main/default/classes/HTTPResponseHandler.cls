public class HTTPResponseHandler {
    private final String CHAR_SLASH = '/';
    
    private String fullURI;
    private String resourceId;
    
    public HTTPResponseHandler() {
		fullURI = RestContext.request.requestURI;
        resourceId = fullURI.substringAfterLast(CHAR_SLASH);
    }
    public void processCallin() {
        AbstractResponser responser = new ResponseFactory().getResponseByType(resourceId);
        setBody(responser.main());
    }
    private void setBody(String responseBody) {
		RestContext.response.responseBody = Blob.valueOf(responseBody.replace('&quot;', '"'));
    }
}