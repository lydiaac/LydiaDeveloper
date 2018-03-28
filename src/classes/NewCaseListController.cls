public with sharing class NewCaseListController {

	private String status = 'New';

	public List<Case> getNewCases() {

	    List<Case> results = new List<Case>();

	    results = [Select Id,CaseNumber from case where status='New'];

	    return results;
	}

}