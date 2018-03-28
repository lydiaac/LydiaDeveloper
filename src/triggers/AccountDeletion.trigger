trigger AccountDeletion on Account (before delete) {
   
    //Impedir la eliminación de una cuenta si tiene oportunidades relacionadas.
    for (Account a : [SELECT Id FROM Account
                     WHERE Id IN (SELECT AccountId FROM Opportunity) AND
                     Id IN :Trigger.old]) {
        Trigger.oldMap.get(a.Id).addError(
            'Cannot delete account with related opportunities.');
    }
    
}