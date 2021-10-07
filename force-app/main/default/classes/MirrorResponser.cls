public class MirrorResponser extends AbstractResponser {
    public override String main() {
        return RestContext.request.requestBody.toString();
    }
}