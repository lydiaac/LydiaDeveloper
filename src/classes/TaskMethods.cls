public with sharing class TaskMethods {

	public static void CerrarTarea (List<Task> listTask, Map<Id,Task> mapTaskOld) {
		
		if(!listTask.isEmpty()){

			//Lista de cuentas a actualizar
			List<Account> listAcUpdate = new List<Account>();

			//Lista de los ids de las tareas cambiadas a 'Completed'
			Set<String> setTaskIds = new Set<String> ();

			for (Task inTask : listTask) {
				if(mapTaskOld.get(inTask.Id).Status != 'Completed' && inTask.Status == 'Completed'){
					setTaskIds.add(inTask.Id);
				}
			}

			//Lista de tareas
			List<Task> listTaskType = new List<Task>([
			SELECT WhatId, ActivityDate,
			  	TYPEOF What
			  	WHEN Account THEN Id, Parent.Fecha_ultima_actividad_mas_reciente__c
			  	WHEN Opportunity THEN Account.Parent.Fecha_ultima_actividad_mas_reciente__c
			  	END
			FROM Task WHERE Id IN : setTaskIds]);

			System.debug('TaskMethods.CerrarTarea.listTaskType :: ' + listTaskType);

			//Dependiendo si recibe account u oportunity...
			for(Task inTask : listTaskType){
				if (inTask.What instanceof Opportunity) {
					System.debug('Opportunity');
					if(inTask.ActivityDate > ((Opportunity)inTask.What).Account.Parent.Fecha_ultima_actividad_mas_reciente__c){
						((Opportunity)inTask.What).Account.Parent.Fecha_ultima_actividad_mas_reciente__c = inTask.ActivityDate;
						listAcUpdate.add(((Opportunity)inTask.What).Account.Parent);
					}
	            } else if (inTask.What instanceof Account) {
	            	System.debug('Account');
	            	//System.debug('veamos.. ->'+((Account)inTask.What).Parent.Fecha_ultima_actividad_mas_reciente__c);
					if(inTask.ActivityDate > ((Account)inTask.What).Parent.Fecha_ultima_actividad_mas_reciente__c){
						((Account)inTask.What).Parent.Fecha_ultima_actividad_mas_reciente__c = inTask.ActivityDate;
						listAcUpdate.add(((Account)inTask.What).Parent);
					}
	            }
	        }
	        System.debug('listAcUpdate ' + listAcUpdate);
	        update listAcUpdate;
		}

	}
}