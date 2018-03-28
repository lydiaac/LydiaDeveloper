public with sharing class AccountHandler {
	
	public static Account insertNewAccount(String accName){

		Account a = new Account();
	
		try{
			a.Name = accName;
			a.AccountNumber = '11111111';
			insert a;
		}catch (exception e){
			return null;
		}
			return a;
	}

}







		//*****declaraciones DML -> try catch excepcion y para el programa
		
		//Account acct = new Account(Name='Acme', Phone='(415)555-1212', NumberOfEmployees=100);
		// Insert the account by using DML
		//insert acct;

		//insert, update, upsert(insert+update), delete, undelete, merge

		// Upsert the contact by using the idLookup field for matching.
		// Verify that the contact has been updated
		//System.assertEquals('Prefers to be contacted by email.',
                   //[SELECT Description FROM Contact WHERE Id=:jane.Id].Description);


        //Contact[] contactsDel = [SELECT Id FROM Contact WHERE LastName='Smith']; 
		//delete contactsDel;


		///////////////////////
		//*****métodos de base de datos -> en caso de excepcion aun lo puedes arreglar y no parar todo

		//Database.insert(recordList, false);
		//Database.insert(),Database.update(),Database.upsert(),Database.delete(),Database.undelete(),Database.merge()

		//Guardar los errores que aparecen al insertar
		//Database.SaveResult[] results = Database.insert(recordList, false);
		//Database.UpsertResult, Database.DeleteResult

		//recorres la lista de errores...
		//for (Database.SaveResult sr : srList) {
		//    if (sr.isSuccess()) {
		//        // Operation was successful, so get the ID of the record that was processed
		//        System.debug('Successfully inserted contact. Contact ID: ' + sr.getId());
		//    } else {
		//        // Operation failed, so get all errors
		//        for(Database.Error err : sr.getErrors()) {
		//            System.debug('The following error has occurred.');
		//            System.debug(err.getStatusCode() + ': ' + err.getMessage());
		//            System.debug('Contact fields that affected this error: ' + err.getFields());
		//	 }
		//    }
		//}
	//}
//}