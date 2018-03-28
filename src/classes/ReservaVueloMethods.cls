public with sharing class ReservaVueloMethods {


	public static List<Reserva_Vuelo__c> RellenarCuenta (List<Reserva_Vuelo__c> reservas) {

		if(!reservas.isEmpty()){

		//PARA UN CASO!
		//Reserva_Vuelo__c reserva = Trigger.new;
		//for (Reserva_Vuelo__c rv : Trigger.new) {
		//	String contactoId = rv.Contacto__c;
		//	Contact c = [SELECT Name, AccountId FROM Contact WHERE accountId =: contactoId ];
		//	rv.Cuenta__c = c.AccountId;
		//}

		//2.De la tabla reservas, sacamos la columna de ContactoID(String) en una lista tipo Set
		Set<String> contactosIds = new Set<String> ();
		for (Reserva_Vuelo__c rv : reservas) {
			contactosIds.add(rv.Contacto__c);
		}

		//3.Hacemos un mapa (ContactoID, Contacto)
		Map<String, Contact> contactos = new Map<String, Contact>();
		for(String c : contactosIds){
			contactos.put(c, [SELECT AccountId FROM Contact WHERE id=:c LIMIT 1]);
		}

  		//4.Recorremos otra vez las reservas y le damos valor a las cuentas obteniendo los valores del Map
		for (Reserva_Vuelo__c rv : reservas) {
			//Contact c = contactos.get(rv.Contacto__c);
			//rv.Cuenta__c = c.AccountId;
			rv.Cuenta__c = contactos.get(rv.Contacto__c).AccountId;
		}
		}

		return reservas;
		
	}

	public static Reserva_Vuelo__c Modificado (Reserva_Vuelo__c oldRv, Reserva_Vuelo__c rv) {
		if((oldRv.Origen__c != rv.Origen__c) || (oldRv.Destino__c != rv.Destino__c)){
			rv.Modificado__c = True;
		}
		return rv;
	}

}