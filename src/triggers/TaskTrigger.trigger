trigger TaskTrigger on Task (after update) {

	List<Task> listNew = Trigger.new;

	Map<Id, Task> mapOld = Trigger.oldMap;


	if (trigger.isAfter) {
		if (trigger.isUpdate) {
			TaskMethods.CerrarTarea(listNew);
		}
	}

}