public with sharing class TaskMethods {

	public static void CerrarTarea (List<Task> listTask, Map<Id,Task> mapTaskOld) {
		
		if(!listTask.isEmpty()){

			//Lista de cuentas a actualizar
			List<Account> listAcUpdate = new List<Account>();

			//Dependiendo si recibe account u oportunity...
			for(Task inTask : [SELECT WhatId, ActivityDate, Status,
								  	TYPEOF What
								  	WHEN Account THEN Id, Parent.Fecha_ultima_actividad_mas_reciente__c
								  	WHEN Opportunity THEN Account.Parent.Fecha_ultima_actividad_mas_reciente__c
								  	END
								FROM Task 
								WHERE Id IN : listTask]){

					if(mapTaskOld.get(inTask.Id).Status != inTask.Status && inTask.Status == 'Completed'){
						if (inTask.whatId.getSObjectType() == Opportunity.sObjectType  /*inTask.What instanceof Opportunity*/) {
							System.debug('Opportunity');
							listAcUpdate.addall(getListAccounts(inTask, ((Opportunity)inTask.What).Account.Parent));

			            } else if (inTask.whatId.getSObjectType() == Account.sObjectType) {
			            	System.debug('Account');
			            	listAcUpdate.addall(getListAccounts(inTask, (((Account)inTask.What).Parent)));
			            	//System.debug('veamos.. ->'+((Account)inTask.What).Parent.Fecha_ultima_actividad_mas_reciente__c);
			            }
			        }
	        }
	        System.debug('listAcUpdate ' + listAcUpdate);
	        update listAcUpdate;
		}

	}

	private static List<Account> getListAccounts(Task task, Account acc){
		List<Account> listAcUpdate = new List<Account>();
		if(task.ActivityDate > acc.Fecha_ultima_actividad_mas_reciente__c){
			acc.Fecha_ultima_actividad_mas_reciente__c = task.ActivityDate;
			listAcUpdate.add(acc);
		}
		return listAcUpdate;
	}
}