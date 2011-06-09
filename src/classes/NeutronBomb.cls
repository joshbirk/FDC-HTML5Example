global with sharing class NeutronBomb {

	public List<Quark__c> currentQuarks {get; set;}

	
	global static void deleteQuarks() {
		List<Quark__c> currentQuarks = [SELECT ID, Name, Spin__c from Quark__c LIMIT 10000];
		delete currentQuarks;
	}


	global static void createQuarks() {
		Integer numofQuarks = 900;
		List<Quark__c> quarks = new List<Quark__c>();
		
		for(Integer i = 0; i < numofQuarks; i++) {
			Quark__c q = new Quark__c();
			q.Spin__c = Math.random();
			q.Mass__c = Math.random();
			if(i < 300) {q.Color_Charge__c = 'Red';}
			else if(i < 600) {q.Color_Charge__c = 'Blue';}
			else {q.Color_Charge__c = 'Green';}
			
			quarks.add(q);
		}
		
		insert quarks;
		
		System.debug(quarks.size());
		System.debug(quarks[0].Name);
		
	}
	

}