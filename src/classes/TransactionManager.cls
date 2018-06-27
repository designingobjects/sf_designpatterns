/**
 *  Contains logic required for a given DML transaction
 *
 *	@author	designingobjects@gmail.com
 */
 
 public without sharing class TransactionManager implements ISingleton{
 	
 	private static TransactionManager instance;
 	
 	private Integer triggerDepth;
 	
 	public static TransactionManager getInstance () {
 		if(instance == null) {
 			instance = new TransactionManager();
 			instance.triggerDepth = 0;
 		}
 		return instance;
 	}
 	
 	public Integer getTriggerDepth() {
 		return triggerDepth;
 	}
 	
 	public void incrementTriggerDepth() {
 		triggerDepth++;
 	}
 	
 	public void decrementTriggerDepth() {
 		triggerDepth--;
 	}
 	
 	public Boolean isRootDepth () {
 		return triggerDepth <= 0;
 	}
    
}