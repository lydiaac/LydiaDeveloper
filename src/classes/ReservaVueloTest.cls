@isTest
private class ReservaVueloTest {

	@isTest static void testRellenarCuenta() {

		Account oAccount = new Account(Name='CuentaPrueba0');
		insert oAccount;

		Contact oContact = new Contact(LastName='ContactoPrueba0', Nif__c='47898592B', AccountId=oAccount.Id);
		insert oContact;

		Reserva_Vuelo__c oReserva = new Reserva_Vuelo__c (Name='ReservaPrueba0', 
															Origen__c='Madrid', 
															Destino__c='Roma',
															Case__c='Turista',
															Contacto__c=oContact.Id,
															Fecha_Salida__c=Datetime.newInstance((Integer)System.Today().Year()+1, 1, 11),
															Observaciones__c='Nada');

		//insert oReserva;

		Reserva_Vuelo__c oReserva2 = new Reserva_Vuelo__c (Name='ReservaPrueba2', 
															Origen__c='Madrid', 
															Destino__c='Roma',
															Case__c='Turista',
															Contacto__c=oContact.Id,
															Fecha_Salida__c=Datetime.newInstance((Integer)System.Today().Year()+1, 1, 11),
															Observaciones__c='Nada');

		//insert oReserva2;

		List<Reserva_Vuelo__c> listReservas = new List<Reserva_Vuelo__c>();

		listReservas.add(oReserva);
		listReservas.add(oReserva2);

		insert listReservas;

		//ReservaVueloMethods.RellenarCuenta(listReservas);

		Reserva_Vuelo__c oReservaCheck = [SELECT Cuenta__c FROM Reserva_Vuelo__c WHERE Id = :listReservas.get(0).Id];

		System.assertEquals(oReservaCheck.Cuenta__c,oAccount.Id);

	}

	@isTest static void testModificado() {

		Contact oContact = new Contact(LastName='ContactoPrueba', Nif__c='47898592B');
		insert oContact;

		Reserva_Vuelo__c oReserva = new Reserva_Vuelo__c (Name='ReservaPrueba', 
															Origen__c='Madrid', 
															Destino__c='Roma',
															Case__c='Turista',
															Contacto__c=oContact.Id,
															Fecha_Salida__c=Datetime.newInstance((Integer)System.Today().Year()+1, 1, 11),
															Observaciones__c='Nada');
		insert oReserva;

		oReserva.Destino__c = 'Berlín';

		update oReserva;

        Reserva_Vuelo__c oReservaCheck = [SELECT Id, Name, Origen__c, Destino__c, Modificado__c FROM Reserva_Vuelo__c WHERE Id = :oReserva.Id];

        System.assert(oReservaCheck.Modificado__c==True);

	}
}