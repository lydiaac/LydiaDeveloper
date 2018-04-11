trigger ReservaVueloTrigger on Reserva_Vuelo__c (before insert, before update) {

	//Lista de nuevas reservas (a insertar)
	List<Reserva_Vuelo__c> listNew = Trigger.new;

	//Lista de reservas antes de modificar
	Map<Id, Reserva_Vuelo__c> mapOld = Trigger.oldMap;


	if (trigger.isBefore) {
		if (trigger.isInsert) {
			ReservaVueloMethods.RellenarCuenta(listNew);
		}
		if(trigger.isUpdate){
			ReservaVueloMethods.Modificado(listNew,mapOld);
		}
	}
}