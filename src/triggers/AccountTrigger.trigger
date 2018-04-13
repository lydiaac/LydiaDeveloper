trigger AccountTrigger on Account (before update) {

	List<Account> listNew = Trigger.new;

	Map<Id, Account> mapOld = Trigger.oldMap;

	if (trigger.isBefore) {
		if(trigger.isUpdate) {
			AccountMethods.ActualizarCuentaHija(listNew, mapOld);
		}
	}
}