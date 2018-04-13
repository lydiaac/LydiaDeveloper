trigger EventTrigger on Event (before insert) {

	List<Event> listNew = Trigger.new;

	if (trigger.isBefore) {
		if (trigger.isInsert) {
			EventMethods.CrearEvento(listNew);
		}
	}

}