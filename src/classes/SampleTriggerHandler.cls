/**
 *  Sample Trigger handler
 *
 *	@author	designingobjects@gmail.com
 */
 public with sharing class SampleTriggerHandler extends TriggerHandlerTemplate implements ISingleton{
   
    private static SampleTriggerHandler instance;
    
    public static SampleTriggerHandler getInstance () {
 		if(instance == null) {
 			instance = new SampleTriggerHandler();
 		}
 		return instance;
 	}
 	
 	/*************************************************************************
	 * before INSERT
	 *************************************************************************/
	protected override void handleBeforeInsert() {
		// Execute actions before insert
    }
}