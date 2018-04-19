public with sharing class AccountMethods {

	public static void ActualizarCuentaHija2 (List<Account> listAccount, Map<Id, Account> mapOld) {

		if(!listAccount.isEmpty()){

			//DE LAS ACCOUNTS QUE ACTUALIZO, ME QUEDO CON (id)
			List<String> listAccountIds = new List<String>();
			Map<String, Account> mapAccountParent = new Map<String, Account>();

			for(Account inAccount : listAccount){
				//Si no tiene parent y se ha modificado fecha
				if((inAccount.ParentId == null) && (inAccount.Fecha_ultima_actividad_mas_reciente__c!=mapOld.get(inAccount.Id).Fecha_ultima_actividad_mas_reciente__c)){
					listAccountIds.add(inAccount.Id);
					mapAccountParent.put(inAccount.Id, inAccount);
				}
			}

			List<Account> listAccountChild = ([SELECT Id, Fecha_ultima_actividad_mas_reciente__c, ParentId FROM Account WHERE ParentId IN :listAccountIds]);

			//RECORRO LA LISTA DE HIJAS Y LAS MODIFICO
			for(Account inAccount : listAccountChild){
				inAccount.Fecha_ultima_actividad_mas_reciente__c = mapAccountParent.get(inAccount.ParentId).Fecha_ultima_actividad_mas_reciente__c;
			}

			update listAccountChild;
		}
		
	}

	public static void ActualizarCuentaHija (List<Account> listAccount, Map<Id, Account> mapOld) {

		if(!listAccount.isEmpty()){

			//DE LAS ACCOUNTS QUE ACTUALIZO, ME QUEDO CON (id)
			List<String> listAccountIds = new List<String>();
			Map<String, Account> mapAccountParent = new Map<String, Account>();

			for(Account inAccount : listAccount){
				//Si no tiene parent y se ha modificado fecha
				if((inAccount.ParentId == null) && (inAccount.Fecha_ultima_actividad_mas_reciente__c!=mapOld.get(inAccount.Id).Fecha_ultima_actividad_mas_reciente__c)){
					listAccountIds.add(inAccount.Id);
					mapAccountParent.put(inAccount.Id, inAccount);
				}
			}

			List<Account> lalala = ([SELECT Id FROM Account WHERE Id IN :listAccount]);
			List<Account> lalala2 = ([SELECT Id, Fecha_ultima_actividad_mas_reciente__c, ParentId FROM Account WHERE ParentId IN (SELECT Id FROM Account WHERE Id IN :listAccount)]);
			//for(Account inAccount : [SELECT Id, Fecha_ultima_actividad_mas_reciente__c, ParentId FROM Account WHERE ParentId IN (SELECT Id FROM Account WHERE Id IN :listAccount)]){

			//}


			//RECORRO LA LISTA DE HIJAS Y LAS MODIFICO
			//for(Account inAccount : [SELECT Id, Fecha_ultima_actividad_mas_reciente__c, ParentId FROM Account WHERE ParentId IN :listAccountIds]){
			//	inAccount.Fecha_ultima_actividad_mas_reciente__c = mapAccountParent.get(inAccount.ParentId).Fecha_ultima_actividad_mas_reciente__c;
			//}

			//update listAccountChild;
		}
		
	}
}