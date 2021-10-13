public class MirrorHeadersResponser extends AbstractResponser {
    public override String main() {
        return returnHeadersAsString(RestContext.request.headers);
    }
    private String returnHeadersAsString(Map<String, String> headers) {
        return JSON.serialize(headers);
    }
}