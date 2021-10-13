public class DMLHandler implements DMLUnitOfWork {
    /* **********************
     * Private variables
     * ************************* */
    private Map<Id, sObject> recordsForUpdate;
    private Map<Id, sObject> recordsForInsert;
    private Map<Id, sObject> recordsForDelete;
    private static DMLHandler instance;
    
	/* **********************
    ** Private methods
    ** ********************** */
    private void makeDML() {
        if (recordsForInsert != null && !recordsForInsert.isEmpty()) insertRecords(recordsForInsert.values());
    }
    
    private void updateRecords(List<sObject> records) {
        update records;
    }
    
    private void insertRecords(List<sObject> records) {
        insert records;
    }
    
    private void deleteRecords(List<sObject> records) {
        delete records;
    }
    
	/* **********************
    ** Public methods
    ** ********************** */
    public static DMLHandler getInstance() {
        if (instance == null) {
            instance = new DMLHandler();
        }
        return instance;
    }
    
    public void addDirty(List<sObject> records) {
        
    }
    public void addDirty(sObject record) {
        
    }
    public void addNew(sObject record) {
        if (record != null) {
            if (recordsForInsert == null) {
                recordsForInsert = new Map<Id, sObject>(); 
            }
            recordsForInsert.put(record.Id, record);   
        }
    }
    public void addNew(List<sObject> records) {
        if (records != null && !records.isEmpty()) {
            if (recordsForInsert == null) {
                recordsForInsert = new Map<Id, sObject>(); 
            }
            for (sObject record : records) {
                recordsForInsert.put(record.Id, record);
            }
        }
    }
    
    public void commitWork() {
        Savepoint sp = Database.setSavepoint();
        try
        {
            makeDML();
        } catch (Exception e) {
            Database.rollback(sp);
            throw e;
        } finally {
            
        }
    }
}