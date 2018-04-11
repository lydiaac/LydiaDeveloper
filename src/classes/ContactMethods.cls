public with sharing class ContactMethods {

	public static void ValidarNif (List<Contact> listNew) {
		
		if(!listNew.isEmpty()){

			for(Contact inContact : listNew){
				if(Utils.isNifNie(inContact.Nif__c) == false){
					inContact.addError('Error en el Nif');
				}
			}

			//	//LOS NIF QUE YA TENIA
			//	List<Contact> listContact = [SELECT Nif__c FROM Contact]; 

			//	List<String> listContactNif = new List<string>();

			//	for(Contact inContact : listContact) {
			//		listContactNif.add(inContact.Nif__c);
			//	}

			//	//LOS QUE QUIERO INSERTAR 
			//	for(Contact inContact : listNew){

			//		String numerosNif = inContact.Nif__c.substring(0, 8);

			//		String letraNif = inContact.Nif__c.substring(8, 9);

			//		if(listContactNif.contains(inContact.Nif__c)){
			//			inContact.addError('No se pueden repetir los Nifs');
			//		}else if(!numerosNif.isNumeric()){
			//			inContact.addError('Error en el número Nif');
			//		} else if(!letraNif.isAlpha()){
			//			inContact.addError('Error en la letra Nif');
			//		}
			//	}
			//}

		}
	}
}