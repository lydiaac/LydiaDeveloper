public with sharing class AccountMethods {

	public static void ActualizarCuentaHija (List<Account> listAccount, Map<Id, Account> mapOld) {

		if(!listAccount.isEmpty()){

			//DE LAS ACCOUNTS QUE ACTUALIZO, ME QUEDO CON (id)-> SI UltimaActividad se ha modificado y no tiene parentId
			List<String> listAccountIds = new List<String>();
			Map<String, Account> mapAccountParent = new Map<String, Account>();

			for(Account inAccount : listAccount){
				if((inAccount.ParentId == null) && (inAccount.Fecha_ltima_actividad_m_s_reciente__c!=mapOld.get(inAccount.Id).Fecha_ltima_actividad_m_s_reciente__c)){
					listAccountIds.add(inAccount.Id);
					mapAccountParent.put(inAccount.Id, inAccount);
				}
			}

			//BUSCO LAS ACCOUNT HIJAS
			List<Account> listAccountChild = [SELECT Id, Fecha_ltima_actividad_m_s_reciente__c, ParentId FROM Account WHERE ParentId IN :listAccountIds];

			//RECORRO LA LISTA DE HIJAS Y LAS MODIFICO
			for(Account inAccount : listAccountChild){
				inAccount.Fecha_ltima_actividad_m_s_reciente__c = mapAccountParent.get(inAccount.ParentId).Fecha_ltima_actividad_m_s_reciente__c;
			}

			update listAccountChild;
		}
		
	}
}