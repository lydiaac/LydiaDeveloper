trigger PasajeroTrigger on Pasajero__c (before insert, before update) {


	List<Pasajero__c> listNew = Trigger.new;


	if (trigger.isBefore) {
		if (trigger.isInsert || trigger.isUpdate) {
			PasajeroMethods.ValidarNif(listNew);
			PasajeroMethods.RellenarContacto(listNew);
		}
	}

}