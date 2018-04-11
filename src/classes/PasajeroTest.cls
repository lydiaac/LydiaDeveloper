@isTest
private class PasajeroTest {
		
	@isTest static void RellenarContactoTest() {

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

		insert oReserva;

		Pasajero__c oPasajero = new Pasajero__c(Name='Pasajero0',
													Reserva__c=oReserva.Id,
													Nif__c='47898592B',
													Edad__c=59);
		insert oPasajero;

		Pasajero__c pasajeroCheck = [SELECT Contacto__c FROM Pasajero__c WHERE Id = :oPasajero.Id];

		System.assertEquals(pasajeroCheck.Contacto__c,oContact.Id);


	}

	@isTest static void ValidarNifTest() {

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

		insert oReserva;

		try{
			
			Pasajero__c oPasajero = new Pasajero__c(Name='Pasajero0',
													Reserva__c=oReserva.Id,
													Nif__c='123456781',
													Edad__c=59);

			System.debug('PasajeroTest.ValidarNifTest :: oPasajero ' +oPasajero);

			insert oPasajero;

		} catch(Exception e) {
			System.Assert(e.getMessage().contains('Error en el Nif!'));
		}

		try{
			
			Pasajero__c oPasajero = new Pasajero__c(Name='Pasajero0',
													Reserva__c=oReserva.Id,
													Nif__c='47898592A',
													Edad__c=59);

			System.debug('PasajeroTest.ValidarNifTest :: oPasajero ' +oPasajero);

			insert oPasajero;

		} catch(Exception e) {
			System.Assert(e.getMessage().contains('Error en el Nif!'));
		}

		//try{
			
		//	Pasajero__c oPasajero = new Pasajero__c(Name='Pasajero0',
		//											Reserva__c=oReserva.Id,
		//											Nif__c='123456781',
		//											Edad__c=59);
		//	insert oPasajero;

		//} catch(Exception e) {
		//	System.Assert(e.getMessage().contains('Error en la letra Nif'));
		//}

		//try{
			
		//	Pasajero__c oPasajero = new Pasajero__c(Name='Pasajero0',
		//											Reserva__c=oReserva.Id,
		//											Nif__c='1234567BB',
		//											Edad__c=59);
		//	insert oPasajero;

		//} catch(Exception e) {
		//	System.Assert(e.getMessage().contains('Error en el número Nif'));
		//}
	}

}