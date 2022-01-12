public class MirrorHeadersResponser extends AbstractResponser {
    /* *********************************************
    ** Method Name: main
    ** Description: returns headers of RestContext.request.headers
    ** Parameters: 
    ** Returns: String
    ** ********************************************* */   
    public override String main() {
        return returnHeadersAsString(RestContext.request.headers);
    }

    /* *********************************************
    ** Method Name: returnHeadersAsString
    ** Description: returns JSON of headers
    ** Parameters: 
    ** Returns: String
    ** ********************************************* */   
    private String returnHeadersAsString(Map<String, String> headers) {
        return JSON.serialize(headers);
    }
}