public virtual with sharing class BaseRepository {
	
	protected SOQLFilters filters;
	
	public static BaseRepository.SOQLFilters initFilters() {
		return new BaseRepository.SOQLFilters();
	}

	public BaseRepository(BaseRepository.SOQLFilters filters) {
		this.filters = filters==null ? new BaseRepository.SOQLFilters() : filters;
	}
	
	protected String buildQuery(Set<String> fields, String objName, String whereClause, SOQLFilters filters) {
		if(filters !=null && !String.isBlank(filters.customWhere)) 	whereClause += ' AND ' + filters.customWhere;
		if(!String.isBlank( whereClause )) {
			whereClause = 'WHERE ' + whereClause.trim().removeStart('AND');
		}
		String query = trac_Utils.buildQuery(fields, objName, whereClause);
		if(filters !=null && !String.isBlank(filters.groupBy))          				query += ' GROUP BY ' + filters.groupBy;
		if(filters !=null && !String.isBlank(filters.orderBy))         					query += ' ORDER BY ' + filters.orderBy;
		if(filters !=null && filters.recordLimit != null && filters.recordLimit > 0)	query += ' LIMIT ' + filters.recordLimit;
		return query;
	}
	
	public class SOQLFilters {
		public String customWhere = '';
		public String orderBy = '';
		public String groupBy = '';
		public Integer recordLimit = 0;
	
		public SOQLFilters() {}
		
		public SOQLFilters setCustomWhere(String customWhere) {
			if(String.isNotBlank(customWhere)) 
				this.customWhere = customWhere;			
			return this;
		}
		
		public SOQLFilters setOrderBy(String orderBy) {
			if(String.isNotBlank(orderBy)) 
				this.orderBy = orderBy;
			return this;
		}
		public SOQLFilters setGroupBy(String groupBy) {
			if(String.isNotBlank(groupBy)) 
				this.groupBy = groupBy;
			return this;
		}
		
		public SOQLFilters setRecordLimit(Integer recordLimit) {
			if(recordLimit > 0) 
				this.recordLimit = recordLimit;
			return this;
		}
		
		public Boolean isValid() {				
			if( 	!String.isBlank(this.customWhere)
					|| !String.isBlank(this.orderBy)
					|| !String.isBlank(this.groupBy)
					|| this.recordLimit > 0 )
				return true;			
			throw new QueryException(Label.EXCEPTION_Query_No_SOQL_Filters_Set);
		}
	}
}