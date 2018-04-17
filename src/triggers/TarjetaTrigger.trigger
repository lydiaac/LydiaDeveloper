trigger TarjetaTrigger on Tarjeta_de_cr_dito__c (before insert, before update) {

    List<Tarjeta_de_cr_dito__c> listNew = Trigger.new;

    if (trigger.isBefore) {
        if (trigger.isInsert || trigger.isUpdate) {
            tarjetaMethods.CrearOportunidad(listNew);
        }
    }

}