/**
 *  General purpose exception handler that bubbles up exception up to the root
 *	trigger depth and add user frield error messages.
 *
 *	@author	designingobjects@gmail.com
 */
 	
 global class ExceptionHandler {
   
	/**
	 *	@description
	 *	Handles known and/or identified exceptions and provides a cleaner error message
	 *
	 *	Handler will only handle exceptions at the root trigger level, that is, the first trigger 
	 *	stack. For non-root trigger, it will keep throwing the exception up. 
	 *
	 * 	@param triggerDepth		Trigger depth. Zero(0) is the root trigger.
	 *	@param e				Caught exception
	 *	@param sObjs			Related records
	 *	@return Integer			Returns the current triggerDepth minus 1
	 */
	 public static Integer execute(Integer triggerDepth, Exception e, List<SObject> sObjs) {
		Boolean isExceptionHandled = false;
		if(triggerDepth <=0 ) {
			isExceptionHandled = handleCustomValidationException(e, sObjs);
		}
		
		// If exception is not handled, rethrow exception.
		if(!isExceptionHandled){
			throw e;
		}
		return triggerDepth-1;
	}
	
	 /**
	 *	@description
	 *	Returns true if the exception is caused by a custom validation rule
	 */
	private static Boolean isCustomValidationException (Exception e) {
		if(e!=null && e instanceOf DmlException 
				&& StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION == ((DmlException)e).getDmlType(0)) {
			return true;
		}
		return false;
	}
	
	/**
	 *	@description
	 * 	Replaces the error message caused by cross object validation rules.
	 *	When a validation rule is violated against a record
	 *		Instead of showing this error message:
	 *			"Error:Apex trigger trac_Quote caused an unexpected exception, contact your administrator: trac_Quote: execution of 
	 *			AfterUpdate caused by: System.DmlException: Update failed. First exception on row 0 with id 006c000000GpKocAAF; 
	 *			first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, Record Has Been Locked For Integration: []: Class.trac_QuoteSyncOpp.execute: 
	 *			line 70, column 1"
	 *		It will show this error instead:
	 *			"Record Has Been Locked For Integration"
	 *
	 */
	private static Boolean handleCustomValidationException (Exception e, List<SObject> sObjs) {
		Boolean isExceptionHandled = false;
		if(isCustomValidationException(e) && sObjs!=null) {
			isExceptionHandled = true;
			for(SObject sObj : sObjs) {
				DmlException dmlE = (DmlException) e;
				sObj.addError(dmlE.getDMLMessage(0) + ' (Id:'+dmlE.getDmlId(0)+')');
			}
		}
		return isExceptionHandled;
	}
	
	// TODO handler more exceptions
}