trigger EventTrigger on Event (after insert) {

	List<Event> listNew = Trigger.new;

	if (trigger.isAfter) {
		if (trigger.isInsert) {
			EventMethods.CrearEvento(listNew);
		}
	}

}