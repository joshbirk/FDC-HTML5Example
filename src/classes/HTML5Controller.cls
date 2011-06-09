public with sharing class HTML5Controller {

	public string htmlTag {get; set;}
	public string endHtmlTag {get; set;}
	
	public HTML5Controller() {
		if(ApexPages.currentPage().getParameters().get('cache') != null) {
			htmlTag = '<html manifest="/apex/HTML5Cache?cache='+ApexPages.currentPage().getParameters().get('cache')+'">';
		} else {
			htmlTag = '<html>';
		}
		
		endHtmlTag = '</html>';
		
	}

}