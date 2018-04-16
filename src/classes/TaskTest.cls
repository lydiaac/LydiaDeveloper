@isTest
private class TaskTest {

	//@isTest static void testCerrarTarea() {
		
	//	Account oAccountParent = new Account(Name='CuentaParent');
	//	insert oAccountParent;

	//	Account oAccount = new Account(Name='Cuenta', 
	//									ParentId=oAccountParent.Id, 
	//									Fecha_ltima_actividad_m_s_reciente__c=Date.newInstance(2018, 1, 11));
	//	insert oAccount;

	//	Account oAccount2 = new Account(Name='Cuenta2', 
	//									ParentId=oAccountParent.Id, 
	//									Fecha_ltima_actividad_m_s_reciente__c=Date.newInstance(2018, 1, 11));
	//	insert oAccount2;

	//	Opportunity oOpportunity = new Opportunity(Name='Oportunidad',
	//												CloseDate=Date.newInstance(2020, 1, 11),
	//												StageName='Prospecting',
	//												AccountId=oAccount2.Id);
	//	insert oOpportunity;

	//	List<Task> listTask = new List<Task>();

	//	Task oTask = new Task(Subject='Task', 
	//							Priority='Normal', 
	//							Status='Not Started', 
	//							WhatId=oAccount.Id, 
	//							ActivityDate=Date.newInstance(2020, 1, 11));

	//	listTask.add(oTask);

	//	Task oTask2 = new Task(Subject='Task2', 
	//							Priority='Normal', 
	//							Status='in Progress', 
	//							WhatId=oOpportunity.Id, 	
	//							ActivityDate=Date.newInstance(2022, 1, 11));

	//	listTask.add(oTask2);

	//	insert listTask;

	//	System.debug(oTask);

	//	System.debug(oTask2);

	//	for(Task inTask : listTask){
	//		System.debug(inTask.Id);
	//		inTask.Status = 'Completed';
	//	}

	//	System.debug(oTask);

	//	System.debug(oTask2);

	//	System.debug(listTask);

	//	update listTask;

	//	List<Account> listAccountCheck = [SELECT Id, Fecha_ltima_actividad_m_s_reciente__c FROM Account WHERE Id = :oAccount.Id];

	//	System.AssertEquals(listAccountCheck.get(0).Fecha_ltima_actividad_m_s_reciente__c, listTask.get(0).ActivityDate);
		
	//}
}