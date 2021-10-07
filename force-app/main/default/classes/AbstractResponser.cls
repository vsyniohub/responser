public abstract class AbstractResponser {
    protected Map<Integer, List<Id>> levelDigitMap;
    protected Map<Id, List<Response_Attribute__c>> objectAttributeMap;
    protected List<Integer> sortedLevelsList;
    protected Response_Configuration__c responseConfiguration;
    
    /* *********************************************
    ** Method Name: AbstractResponser
    ** Parameters: no
    ** Returns: void
    ** ********************************************* */
    public AbstractResponser() {
        objectAttributeMap 	= new Map<Id, List<Response_Attribute__c>>();
        levelDigitMap 		= new Map<Integer, List<Id>>();
        sortedLevelsList	= new List<Integer>();
    }
    public void setResponseConfiguration(Response_Configuration__c responseConfiguration) {
        this.responseConfiguration = responseConfiguration;
    }
    public abstract String main();
}