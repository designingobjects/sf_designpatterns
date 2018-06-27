/**
 *  Contains generic methods used by all trigger handlers
 *
 *	@author	designingobjects@gmail.com
 */
public virtual class TriggerHandlerTemplate {
	
	private List<SObject> records;
	private Map<Id, SObject> oldRecords;
	
	private TransactionManager transactionMng = TransactionManager.getInstance();
    
    // Constructors
	public TriggerHandlerTemplate(){
    	if (trigger.isInsert) {
    		this.records = trigger.new;
    		this.oldRecords = new Map<Id, SObject>();
    	
    	} else if(trigger.isUpdate) {
    		this.records = trigger.new;
    		this.oldRecords = trigger.oldMap;
   	
    	} else if(trigger.isDelete) {
    		this.records = new List<SObject>();
    		this.oldRecords = trigger.oldMap;
    	}	    	
	}
	
	// Main exec method	
	public Boolean execute() {
		
		transactionMng.incrementTriggerDepth();

		try{
			if (trigger.isBefore) {
				if (trigger.isInsert) this.handleBeforeInsert();
				if (trigger.isUpdate) this.handleBeforeUpdate();
				if (trigger.isDelete) this.handleBeforeDelete();
			}
			if (trigger.isAfter) {
				if (trigger.isInsert) this.handleAfterInsert();
				if (trigger.isUpdate) this.handleAfterUpdate();
				if (trigger.isDelete) this.handleAfterDelete();
			}
			
			transactionMng.decrementTriggerDepth();
			return true;
			
		} catch (Exception e) {
			transactionMng.decrementTriggerDepth();
			ExceptionHandler.execute(transactionMng.getTriggerDepth(), e, trigger.new);
		}	
		return false;
		
	}
	
	
	// Overridable methods per trigger context
	protected virtual void handleBeforeInsert() {}
	protected virtual void handleBeforeUpdate() {}
	protected virtual void handleBeforeDelete() {}
	protected virtual void handleBeforeUndelete() {}
	protected virtual void handleAfterInsert() {}
	protected virtual void handleAfterUpdate() {}
	protected virtual void handleAfterDelete() {}
	protected virtual void handleAfterUndelete() {}
}