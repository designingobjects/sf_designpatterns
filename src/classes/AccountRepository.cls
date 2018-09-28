public with sharing class AccountRepository extends BaseRepository implements IRepository{
    public static final String OBJ_API_NAME = 'Account';
	
	public static AccountRepository init() {
		return new AccountRepository(null);
	}
	
	public static AccountRepository init(BaseRepository.SOQLFilters params) {
		return new AccountRepository(params);
	}
	
	public AccountRepository(BaseRepository.SOQLFilters params) {
		super(params);
	}
	
	/**
	 *	Retrieves the Account record base on id
	 */
	public Account getById(Set<String> fields, Id accountId){
		List<Account> accounts = getAll(fields, new Set<Id>{accountId});
		if(accounts.isEmpty()) 
			return null;
		return accounts.get(0);
	}
	
	/**
	 *	Retrieves the Account records base on ids 
	 */
	public List<Account> getAllByIds(Set<String> fields, Set<Id> ids){
		return getAll(fields, ids);
	}
	
	/**
	 *	The method that queries the Account records based on the customWhere, orderBy, groupBy and/or recordLimit
	 *
	 *	@param fields	required, the select column names of the SOQL
	 */
	public List<Account> getAllBySOQLFilters(Set<String> fields) {
		if(this.filters.isValid())
			return getAll(fields, null);
		return new List<Account>();
	}
	
	
	/**
	 *	The method that queries the Account records based on AND-ing all non-null/non-empty conditions provided
	 * 	as parameters.
	 *
	 *	@param fields	required, the select column names of the SOQL
	 *	@param *		all optional 
	 */
	@TestVisible
	private List<Account> getAll(
			Set<String> fields, 
			Set<Id> ids) {
				
		List<Account> result = new List<Account>();		
		if(fields != null && !fields.isEmpty()) {
			// Building the SOQL query
			String whereClause = '';
			if(ids != null && !ids.isEmpty()) 							whereClause += ' AND Id in :ids';
			
			String query = buildQuery(fields, AccountRepository.OBJ_API_NAME, whereClause, this.filters);
			
			// Executing the SOQL
			result = Database.query( query );					
		}
		return result;		
	}  
}