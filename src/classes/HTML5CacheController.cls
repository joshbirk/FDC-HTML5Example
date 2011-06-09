public with sharing class HTML5CacheController {
	
	public string currentCache {get; set;}
	
	public HTML5CacheController() {
		currentCache = ApexPages.currentPage().getParameters().get('cache');
	}

}