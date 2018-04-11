public with sharing class GeneralMethods {

	//final static String SOQL_CONTACT = '[SELECT Nif__c FROM Contact]';

	//public static void ValidarNif (List<Contact> listNew) {
		
	//	if(!listNew.isEmpty()){

	//		//LOS NIF QUE YA TENIA
	//		List<Contact> listContact = [SELECT Nif__c FROM Contact]; 

	//		List<Integer> listContactNif = new List<Integer>();

	//		for(Contact inContact : listContact) {
	//			listContactNif.add((Integer)inContact.Nif__c);
	//		}

	//		//COMPARO
	//		for(Contact inContact : listNew){
	//			if(listContactNif.contains((Integer)inContact.Nif__c)){
	//				inContact.addError('No se pueden repetir los Nifs');
	//			}
	//		}

	//	}
	//}

	//public static void ValidarNif (List<SObject> listNew) {

	//	String consulta = '';
		
	//	if(!listNew.isEmpty()){

	//		if(listNew.get(0) instanceof Contact){
	//			consulta = SOQL_CONTACT;
			

	//		}

	//		//LOS NIF QUE YA TENIA
	//		List<SObject> listObject = Database.query(consulta); 

	//		List<Integer> listNif = new List<Integer>();

	//		for(SObject inObject : listObject) {
	//			//listNif.add((Integer)inObject.Nif__c);
	//			if(inObject instanceof Contact){}
	//		}

	//		//COMPARO
	//		//for(SObject inContact : listNew){
	//		//	if(listNif.contains((Integer)inContact.Nif__c)){
	//		//		inContact.addError('No se pueden repetir los Nifs');
	//		//	}
	//		//}

	//	}
	//}
}