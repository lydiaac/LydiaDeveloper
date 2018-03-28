trigger ReservaVueloTrigger on Reserva_Vuelo__c (before insert, before update) {

	//
	//ReservaVueloMethods metodos = new ReservaVueloMethods();

	//Lista de reservas a insertar
	List<Reserva_Vuelo__c> reservas = Trigger.new;

	if (trigger.isBefore) {
		if (trigger.isInsert) {
			reservas = ReservaVueloMethods.RellenarCuenta(reservas);
		}
		if(trigger.isUpdate){
			for (Reserva_Vuelo__c rv : reservas) {
		    	Reserva_Vuelo__c oldRv = Trigger.oldMap.get(rv.Id); //Guarda el valor del campo anterior a la modificacion
		    	rv = ReservaVueloMethods.Modificado(oldRv, rv);
			}
		}
	}
}