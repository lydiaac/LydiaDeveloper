@isTest
private class ReservaVueloTest {

	@isTest static void testRellenarCuenta() {
		//Creas Contact, Account y ReservaVuelo
		//Añadirlo a una lista (el metodo recibe lista)
		//Ejecutar metodo
		//Comprobar el campo Cuenta de ReservaVuelo

		Account acount1 = new Account (Name = 'AccountPrueba');

		Contact contact1 = new Contact (AccountId = acount1.Id);

		Reserva_Vuelo__c rv1 = new Reserva_Vuelo__c (Name = 'ReservaVueloPrueba', Contacto__c = contact1.Id);

		Test.startTest();

		//insert acount1;
		//insert contact1;
		//insert rv1;
		//Test.stopTest();



		//Account acount2 = new Account (Name = 'AccountPrueba2');

		//Contact contact2 = new Contact (AccountId = acount2.Id);

		//Reserva_Vuelo__c rv2 = new Reserva_Vuelo__c (Name = 'ReservaVueloPrueba2', Contacto__c = contact2.Id);



		List<Reserva_Vuelo__c> rvList = new List<Reserva_Vuelo__c>();

		rvList.add(rv1);
		//rvList.add(rv2);



		//ReservaVueloMethods rvm = new ReservaVueloMethods();

		List<Reserva_Vuelo__c> nuevaLista = ReservaVueloMethods.RellenarCuenta(rvList);
		
		System.assertEquals(nuevaLista.get(0).Cuenta__c, acount1.Id);
	}

	@isTest static void testModificar() {

	}
}