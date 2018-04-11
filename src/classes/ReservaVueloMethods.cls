public with sharing class ReservaVueloMethods {


	public static void RellenarCuenta (List<Reserva_Vuelo__c> listReservas) {

		if(!listReservas.isEmpty()){

			//Obtenemos los id de los contactos de las reservas
			Set<String> listContactosIds = new Set<String> ();
			for (Reserva_Vuelo__c inReserva : listReservas) {
				listContactosIds.add(inReserva.Contacto__c);
			}
			
			//Hacemos un mapa (ContactoID, Contacto)

			/*
			Map<String, Contact> contactos = new Map<String, Contact>();
			for(Contact c : [SELECT AccountId FROM Contact WHERE id IN : contactosIds]){
				contactos.put(c.id, c);
			}
			*/

			Map<String, Contact> contactos = new Map<String, Contact>([SELECT AccountId FROM Contact WHERE id IN : listContactosIds]);

	  		//Recorremos otra vez las reservas y le damos valor a las cuentas obteniendo los valores del Map
			for (Reserva_Vuelo__c inReserva : listReservas) {
				inReserva.Cuenta__c = contactos.get(inReserva.Contacto__c).AccountId;
			}
		}
		
	}

	public static void Modificado (List<Reserva_Vuelo__c> listNew, Map<Id, Reserva_Vuelo__c> mapOld) {
		
		for(Reserva_Vuelo__c inReservaVueloNew : listNew) {

			//System.debug('ReservaVueloMethods.Modificado :: inReservaVueloNew ' +inReservaVueloNew);

			Reserva_Vuelo__c inReservaVueloOld = mapOld.get(inReservaVueloNew.Id);

			if((inReservaVueloOld.Origen__c != inReservaVueloNew.Origen__c) || (inReservaVueloOld.Destino__c != inReservaVueloNew.Destino__c)) {
				inReservaVueloNew.Modificado__c = True;
			}
		}

	}

}