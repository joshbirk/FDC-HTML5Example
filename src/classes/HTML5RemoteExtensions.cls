global with sharing class HTML5RemoteExtensions {
	
	public List<Quark__c> quarksAF {get; set;}
	public Decimal SpinLimit {get; set;}
	public Decimal MassLimit {get; set;}
	public Integer SizeOfUniverse {get; set;}
	
	public HTML5RemoteExtensions() { SpinLimit = 1.0; MassLimit = 1.0; quarksAF = new List<Quark__c>(); SizeOfUniverse = 0; }
	
	public HTML5RemoteExtensions(ApexPages.StandardController controller) { SpinLimit = 1.0; MassLimit = 1.0; quarksAF = new List<Quark__c>(); SizeOfUniverse = 0; }
	
	public PageReference createTestData() {
		List<Quark__c> quarks = [SELECT ID, Name, Spin__c, Mass__c, Color_Charge__c from Quark__c];
		if(quarks.size() == 0) {
			NeutronBomb.createQuarks();
		}
		
		return null;
    	
	}
	
	public PageReference deleteTestData() {
		NeutronBomb.deleteQuarks();
		
		return null;
    	
	}
	
    //FILTER Quarks via ActionFunction
    public PageReference filterQuarksAF() {
    	quarksAF = [SELECT ID, Name, Spin__c, Mass__c, Color_Charge__c from Quark__c WHERE Spin__c < :SpinLimit AND Mass__c < :MassLimit];
    	SizeOfUniverse = quarksAF.size();
    	return null;
    }
    
    
    //GET Quarks via RemoteAction
    @RemoteAction
    global static List<Quark__c> filterQuarks(Decimal spin, Decimal mass) {
    	List<Quark__c> quarks = [SELECT ID, Name, Spin__c, Mass__c, Color_Charge__c from Quark__c WHERE Spin__c < :spin AND Mass__c < :mass];
    	return quarks;
    }
    
    
    @IsTest
    static void testQuarks() {
    	NeutronBomb.createQuarks();
    	PageReference af = Page.ActionFunctionPage;
    	Test.setCurrentPage(af);
    	
    	HTML5RemoteExtensions html5 = new HTML5RemoteExtensions();
    	html5.createTestData();
    	
    	html5.SpinLimit = 0.7;
    	html5.MassLimit = 0.7;
    	
    	
    	html5.filterQuarksAF();
    	List<Quark__c> remoteQuarks = HTML5RemoteExtensions.filterQuarks(0.7,0.7);
    	System.assertEquals(html5.quarksAF,remoteQuarks);
    	
    	PageReference html5Page = Page.HTML5QuarkGraphOffline;
    	Test.setCurrentPage(html5Page);
    	ApexPages.currentPage().getParameters().put('cache','unittest');
    	ApexPages.currentPage().getParameters().put('page','HTML5QuarkGraphOffline');
    	
    	HTML5Controller html5Controller = new HTML5Controller();
    	System.assertNotEquals(html5Controller.htmlTag,'<html>');
    	
    	HTML5CacheController html5cache = new HTML5CacheController();
    	
    	html5.deleteTestData();
    	
    	
    }
   
  


}