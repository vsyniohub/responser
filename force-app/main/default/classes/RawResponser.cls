public class RawResponser extends AbstractResponser {
    
    public RawResponser(String resourceId) {
        
    }
    public override String main() {
        return responseConfiguration.Raw_Response__c;
    }
}