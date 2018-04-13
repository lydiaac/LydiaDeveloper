@isTest
private class TarjetaTest {

	@isTest static void testCrearOportunidad() {
		
		User userAborda = [SELECT Alias FROM User WHERE Alias = 'test' LIMIT 1];

		Account oAccount = new Account(Name='CuentaPrueba0');
		insert oAccount;

		Contact oContact = new Contact(LastName='ContactoPrueba0', Nif__c='47898592B', AccountId=oAccount.Id, Premium__c=True);
		insert oContact;

		Tarjeta_de_cr_dito__c oTarjeta = new Tarjeta_de_cr_dito__c(A_o_caducidad__c=(Integer)System.Today().Year()+1,
												Contacto__c = oContact.Id,
												Mes_de_caducidad__c = (Integer)System.Today().Month(),
												N_tarjeta__c = '1234567891234567',
												Tarjeta__c = 'Crédito',
												Tipo_de_tarjeta__c = 'MasterCard',
												Name = 'Tarjeta0',
												OwnerId = userAborda.Id
												);
		insert oTarjeta; //update por usuario....

		//SE INSERTA LA OPORTUNIDAD, la buscamos y comprobamos

		List<Opportunity> listOpportunity = [SELECT Id, Name, CloseDate, StageName, AccountId FROM Opportunity WHERE Name = :oContact.LastName];

		System.assertEquals(listOpportunity.get(0).CloseDate,Date.newInstance((Integer)oTarjeta.A_o_caducidad__c, 01, (Integer)oTarjeta.Mes_de_caducidad__c));
		System.assertEquals(listOpportunity.get(0).StageName,'No iniciado');
		System.assertEquals(listOpportunity.get(0).AccountId,oContact.AccountId);

	}
}