@isTest
private class TaskTest {

	@isTest static void testCerrarTarea() {
		
		Account oAccountParent = new Account(Name='CuentaPadre',
											Fecha_ultima_actividad_mas_reciente__c=Date.newInstance(2018, 1, 11));
		insert oAccountParent;

		Account oAccount = new Account(Name='Cuenta', 
										ParentId=oAccountParent.Id, 
										Fecha_ultima_actividad_mas_reciente__c=Date.newInstance(2018, 1, 11));
		insert oAccount;

		Opportunity oOpportunity = new Opportunity(Name='Oportunidad',
													CloseDate=Date.newInstance(2020, 1, 11),
													StageName='Prospecting',
													AccountId=oAccount.Id);
		insert oOpportunity;

		//TEST ACCOUNT

		List<Task> listTask = new List<Task>();

		Task oTask = new Task(Subject='Task', 
								Priority='Normal', 
								Status='Not Started', 
								WhatId=oAccount.Id, 
								ActivityDate=Date.newInstance(2020, 1, 11));

		listTask.add(oTask);

		insert listTask;

		for(Task inTask : listTask){
			inTask.Status = 'Completed';
		}

		update listTask;

		List<Account> listAccountCheck = [SELECT Id, Fecha_ultima_actividad_mas_reciente__c FROM Account WHERE Id = :oAccountParent.Id];

		System.debug(listAccountCheck);

		System.AssertEquals(listAccountCheck.get(0).Fecha_ultima_actividad_mas_reciente__c, listTask.get(0).ActivityDate);
		

		//TEST OPPORTUNITY

		Task oTask2 = new Task(Subject='Task2', 
								Priority='Normal', 
								Status='in Progress', 
								WhatId=oOpportunity.Id, 	
								ActivityDate=Date.newInstance(2022, 1, 11));

		listTask.add(oTask2);

		upsert listTask;

		for(Task inTask : listTask){
			inTask.Status = 'Completed';
		}

		update listTask;

		List<Account> listAccountCheckDos = [SELECT Id, Fecha_ultima_actividad_mas_reciente__c FROM Account WHERE Id = :oAccountParent.Id];

		System.debug(listAccountCheck);

		System.AssertEquals(listAccountCheckDos.get(0).Fecha_ultima_actividad_mas_reciente__c, listTask.get(1).ActivityDate);
	}
}