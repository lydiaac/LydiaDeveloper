trigger ContactTrigger on Contact (before insert, before update) {

    List<Contact> listNew = Trigger.new;

    if (trigger.isBefore) {
        if (trigger.isInsert || trigger.isUpdate) {
            ContactMethods.ValidarNif(listNew);
        }
    }

}