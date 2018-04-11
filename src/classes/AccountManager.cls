@RestResource(urlMapping='/Accounts/<Account_ID>/contacts')
global with sharing class AccountManager {

	@HttpGet
	global static Account getAccount() {









		RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String caseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        
        Case result =  [SELECT CaseNumber,Subject,Status,Origin,Priority
                        FROM Case
                        WHERE Id = :caseId];
        return result;





		
	}
}