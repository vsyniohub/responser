public class ConfiguredResponser extends AbstractResponser {
    private Map<Id, Response_Object__c> responseObjectMap;
    private Map<Id, Response_Attribute__c> responseAttributesMap;
    private Set<Integer> sortedLevelsSet;
    private Boolean sortNeeded = false;
    private String responseText;
    private String resourceId;
    
    public void setSortable(Boolean sortNeeded) {
        this.sortNeeded = sortNeeded;
    }
    
   /* *********************************************
    ** Method Name: main
    ** Parameters: no
    ** Returns: String, returns JSON
    ** ********************************************* */
    public override String main() {
        queryResponseConfiguration(resourceId);
        queryResponseObjects(resourceId);
        queryResponseAttributes(resourceId);
        //setSortable(true);
        buildLevelMap();
        //arrangeLevels();
        return buildJSON();
    }
    
    private void queryResponseConfiguration(String resourceId) {
        responseConfiguration = [SELECT Id, RecordTypeId FROM Response_Configuration__c WHERE Id = :resourceId];    
        if (responseConfiguration == null) {
            throw new SObjectException('No configuration');
        } 
    }
    private void queryResponseObjects(String resourceId) {
        responseObjectMap = new Map<Id, Response_Object__c>([SELECT Id, Name, Response_Configuration__c, Response_Object__c  
                                                             FROM Response_Object__c WHERE Response_Configuration__c = :resourceId]);
        if (responseObjectMap == null || responseObjectMap.isEmpty()) {
            throw new SObjectException('No objects');
        }
    }
    private void queryResponseAttributes(String resourceId) {
        responseAttributesMap = new Map<Id, Response_Attribute__c>([SELECT Id, Response_Object__c, Response_Configuration__c, Tag_Name__c, Value__c 
                                                                    FROM Response_Attribute__c WHERE Response_Configuration__c = :resourceId]);
    }
    public ConfiguredResponser(String resourceId) {
        super();
        this.resourceId = resourceId;
    }
    
	/* *********************************************
	** Method Name: buildLevelMap
	** Description: builds map of level vs node id
	** Parameters: no
	** Returns: void
	** ********************************************* */
    private void buildLevelMap() {
        for (Id attributeKey : responseAttributesMap.keySet()) {
            Response_Attribute__c attribute = responseAttributesMap.get(attributeKey);
            if (objectAttributeMap.containsKey(attribute.Response_Object__c)) {
                objectAttributeMap.get(attribute.Response_Object__c).add(attribute);
            } else {
                objectAttributeMap.put(
                    attribute.Response_Object__c,
                    new List<Response_Attribute__c>{attribute}
                );
            }
        }
        
        Boolean topLevelFound = false;
        while (responseObjectMap.size() > 0) {
            System.debug('SIZE: ' + responseObjectMap.size());

            for (Id responseKey : responseObjectMap.keySet()) {
                Response_Object__c responseNode = responseObjectMap.get(responseKey);
                
                if (responseNode.Response_Object__c == null) {
                    this.levelDigitMap.put(0, new List<Id>{responseKey});
                    this.sortedLevelsList.add(0);
                    
                    topLevelFound = true;
                    responseObjectMap.remove(responseKey);
                    break;
                } else if (topLevelFound) {
                    Integer level = getParentLevel(this.levelDigitMap, responseNode.Response_Object__c);
                    if (this.levelDigitMap.get(level + 1) != null) {
                        this.levelDigitMap.get(level + 1).add(responseKey);
                    } else {
                        this.levelDigitMap.put(level + 1, new List<Id>{responseKey});
                    }
                    this.sortedLevelsList.add(level + 1);
                    responseObjectMap.remove(responseKey);
                    continue;                        
                }
            }   
        }     
        System.debug(this.levelDigitMap);
    }
    
    /* *********************************************
	** Method Name: buildJSON
	** Description: builds JSON based on level map
	** Parameters: 
	** Returns: String
	** ********************************************* */
    private String buildJSON() {
        JSONGenerator gen = JSON.createGenerator(true);
        
        gen.writeStartObject();
        for (Integer level = 0; level < this.levelDigitMap.keySet().size(); level++) {
            if (this.levelDigitMap.containsKey(level)) {
                List<Id> nodes = this.levelDigitMap.get(level);

                if (level == 0) {
                    for (Id attribute : responseAttributesMap.keySet()) {
                        if (responseAttributesMap.get(attribute).Response_Object__c == nodes[0]) {
                            gen.writeStringField(
                                responseAttributesMap.get(attribute).Tag_Name__c, 
                                responseAttributesMap.get(attribute).Value__c
                            );
                        }
                    }
                } else {
                    
                }
            }
        }
        gen.writeEndObject();
        
        return gen.getAsString();
    }
    
	/* *********************************************
	** Method Name: getParentLevel
	** Description: 
	** Parameters: Map<Integer, Set<Id>> - current level map, Id - 
	** Returns: Integer
	** ********************************************* */
    private Integer getParentLevel(Map<Integer, List<Id>> levelDigitMap, Id parentNodeId) {
        for (Integer level : levelDigitMap.keySet()) {
            if (levelDigitMap.get(level).contains(parentNodeId)) {
                return level;
            }
        }  
        return -1;
    }
    
    /* *********************************************
	** Method Name: arrangeLevels
	** Description: 
	** Parameters: no
	** Returns: void
	** ********************************************* */
    private void arrangeLevels() {
        if (this.sortNeeded) {
            sortedLevelsList.sort();
            sortedLevelsSet = new Set<Integer>();
            for (Integer level : sortedLevelsList) {
                sortedLevelsSet.add(level);
            } 
        } else {
            for (Integer level : this.levelDigitMap.keySet()) {
                sortedLevelsSet.add(level);
            }
        }
    }
}