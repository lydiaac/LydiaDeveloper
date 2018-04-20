trigger AccountTrigger on Account (after update) {

	List<Account> listNew = Trigger.new;

	Map<Id, Account> mapOld = Trigger.oldMap;

	if (trigger.isAfter) {
		if(trigger.isUpdate) {
			AccountMethods.ActualizarCuentaHija(listNew, mapOld);
		}
	}
}