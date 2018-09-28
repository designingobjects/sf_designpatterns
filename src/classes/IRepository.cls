public Interface IRepository{
    IRepository init();
    IRepository init(BaseRepository.SOQLFilters params);
    
    List<SObject> getAllBySOQLFilters(Set<String> fields);	
}