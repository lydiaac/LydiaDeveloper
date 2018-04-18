@isTest
private class EventTest {

	@isTest static void testCrearEventoCuenta() {

		Account oAccountParent = new Account(Name='CuentaPadre',
											Fecha_ultima_actividad_mas_reciente__c=Date.newInstance(2018, 1, 11));
		insert oAccountParent;

		Account oAccount = new Account(Name='Cuenta', 
										ParentId=oAccountParent.Id, 
										Fecha_ultima_actividad_mas_reciente__c=Date.newInstance(2018, 1, 11));
		insert oAccount;


		List<Event> listEvent = new List<Event>();

		Event oEvent = new Event(Subject='Event', 
								IsAllDayEvent=True, 
								WhatId=oAccount.Id,
								ActivityDate=Date.newInstance(2020, 1, 11));

		listEvent.add(oEvent);

		insert listEvent;

		List<Account> listAccountCheck = [SELECT Id, Fecha_ultima_actividad_mas_reciente__c FROM Account WHERE Id = :oAccountParent.Id];

		System.debug(listAccountCheck);

		System.AssertEquals(listAccountCheck.get(0).Fecha_ultima_actividad_mas_reciente__c, listEvent.get(0).ActivityDate);
		
	}

	@isTest static void testCrearEventoOportunidad() {

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


		List<Event> listEvent = new List<Event>();

		Event oEvent = new Event(Subject='Event2', 
								IsAllDayEvent=True, 
								WhatId=oOpportunity.Id, 
								ActivityDate=Date.newInstance(2020, 1, 11));

		listEvent.add(oEvent);

		insert listEvent;

		List<Account> listAccountCheck = [SELECT Id, Fecha_ultima_actividad_mas_reciente__c FROM Account WHERE Id = :oAccountParent.Id];

		System.debug(listAccountCheck);

		System.AssertEquals(listAccountCheck.get(0).Fecha_ultima_actividad_mas_reciente__c, listEvent.get(0).ActivityDate);
		
	}
}