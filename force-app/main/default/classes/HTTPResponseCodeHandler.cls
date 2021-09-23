public class HTTPResponseCodeHandler {
    private final Map<String, Integer> CODES_MAP = new Map<String, Integer>{
        'OK' => 200
    };
    private final Integer DEFAULT_CODE_INTEGER = 200;
    private Integer httpResponseCode;
    private static HTTPResponseCodeHandler instance;
    
    private HTTPResponseCodeHandler() {
        
    }
    public static HTTPResponseCodeHandler getInstance() {
        if (instance == null) {
            instance = new HTTPResponseCodeHandler();
        }
        return instance;
    }
    public Integer getHttpResponseCode() {
        if (httpResponseCode == null) {
            return DEFAULT_CODE_INTEGER;
        } else {
            return this.httpResponseCode;
        }
    }
    public void setHttpResponseCode(Integer code) {
        this.httpResponseCode = code;
    }
    public void setHttpResponseCode(String code) {
        this.httpResponseCode = CODES_MAP.get(code); //check null
    }
}