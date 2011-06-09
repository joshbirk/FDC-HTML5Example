global class remoteTest {
	
	public List<Quark__c> quarksAF {get; set;}
	public Decimal SpinLimit {get; set;}
	public Decimal MassLimit {get; set;}
	public Integer SizeOfUniverse {get; set;}
	
	public remoteTest() { SpinLimit = 1.0; MassLimit = 1.0; quarksAF = new List<Quark__c>(); SizeOfUniverse = 0; }
	
	public remoteTest(ApexPages.StandardController controller) { SpinLimit = 1.0; MassLimit = 1.0; quarksAF = new List<Quark__c>(); SizeOfUniverse = 0; }
	
    @RemoteAction
    global static List<Contact> findContacts(string Name) {
        Name = '%'+Name+'%';
        List<Contact> c = [SELECT ID, Name, Phone, Email from Contact where NAME LIKE :Name ];
        return c;
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
    
    @RemoteAction
    global static String createContact(string FirstName, string LastName) {
       Contact c = new Contact(FirstName=FirstName,LastName=LastName);
       insert c;
       return c.Id; 
       
    }
    
  


}