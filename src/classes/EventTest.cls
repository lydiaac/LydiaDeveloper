@isTest
private class EventTest {

	@isTest static void testCrearEvento() {

		Account oAccountParent = new Account(Name='CuentaParent');
		insert oAccountParent;

		Account oAccount = new Account(Name='Cuenta', 
										ParentId=oAccountParent.Id, 
										Fecha_ltima_actividad_m_s_reciente__c=Date.newInstance(2018, 1, 11));
		insert oAccount;

		Event oEvent = new Event(StartDateTime=Date.newInstance(2020, 1, 11),
								EndDateTime=Date.newInstance(2020, 1, 11),
								IsAllDayEvent=True,
								WhatId=oAccount.Id
							);
		insert oEvent;

		List<Account> listAccountCheck = [SELECT Fecha_ltima_actividad_m_s_reciente__c FROM Account WHERE Id = :oAccount.Id];
		
		//Al insertar el evento, rellena el campo ActivityDate -> lo recuperamos
		List<Event> listEventCheck = [SELECT ActivityDate FROM Event WHERE Id = :oEvent.Id];

		System.AssertEquals(listAccountCheck.get(0).Fecha_ltima_actividad_m_s_reciente__c, listEventCheck.get(0).ActivityDate);
		
		
	}
}