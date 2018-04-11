public with sharing class PasajeroMethods {

	public static void RellenarContacto (List<Pasajero__c> listPasajeros) {

		if(!listPasajeros.isEmpty()){

			//Obtenemos la lista de los nif de los pasajeros
			List<String> listNifs = new List<String>();

			for(Pasajero__c inPasajero : listPasajeros){
				listNifs.add(inPasajero.Nif__c);
			}

			//Hacemos un mapa (nif,Contacto)
			//List<Contact> listContactos = [SELECT Id, Name, Nif__c FROM Contact WHERE Nif__c IN :listNifs];

			Map<String, Contact> mapContactos = new Map<String, Contact>();

			for(Contact inContact : [SELECT Id, Name, Nif__c FROM Contact WHERE Nif__c IN :listNifs]){ //: listContactos
				mapContactos.put(inContact.Nif__c, inContact);
			}

			//Recorremos los pasajeros y les damos valor al campo contacto segun el nif
	  		for(Pasajero__c inPasajero : listPasajeros){
	  			if(mapContactos.get(inPasajero.Nif__c) != null){
					inPasajero.Contacto__c = mapContactos.get(inPasajero.Nif__c).Id;
				}
	  		}
		}
	}

	public static void ValidarNif (List<Pasajero__c> listNew){
		
		if(!listNew.isEmpty()){

			for(Pasajero__c inPasajero : listNew){
				if(Utils.isNifNie(inPasajero.Nif__c) == false){
					inPasajero.addError('Error en el Nif!');
				}
			}

		}
	}
}