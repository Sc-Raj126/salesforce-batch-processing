global class DataProcessingBatch implements Database.Batchable<SObject>, Database.Stateful {
    global Integer recordCount = 0;
    
    global Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }
    
    global void execute(Database.BatchableContext context, List<SObject> scope) {
        List<Account> accounts = (List<Account>) scope;
        recordCount += accounts.size();
        
        for (Account acc : accounts) {
            acc.Description = 'Processed by batch job';
        }
        
        update accounts;
    }
    
    global void finish(Database.BatchableContext context) {
        System.debug('Batch job completed. Total records processed: ' + recordCount);
    }
}
