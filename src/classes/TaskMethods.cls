public with sharing class TaskMethods {

	public static void CerrarTarea (List<Task> listTask, Map<Id,Task> mapTaskOld) {
		
		if(!listTask.isEmpty()){

			//lista de cuentas
			Map<Id,Account> mapAccounts = new Map<Id,Account>([SELECT Id, Fecha_ultima_actividad_mas_reciente__c, ParentId FROM Account]);

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

			//Dependiendo si es account u oportunity...
			for(Task inTask : listTaskType){
				if (inTask.What instanceof Opportunity) {
					System.debug('Opportunity');
					Account accAux = mapAccounts.get(inTask.AccountId);

					if(inTask.ActivityDate > mapAccounts.get(accAux.ParentId).Fecha_ultima_actividad_mas_reciente__c){

						listAcUpdate.add(mapAccounts.get(accAux.ParentId));

						listAcUpdate.get(0).Fecha_ultima_actividad_mas_reciente__c= inTask.ActivityDate;

						System.debug('ENTRA');
						
					}
	            } else if (inTask.What instanceof Account) {
	            	System.debug('Account');
	            	System.debug('TaskMethods.CerrarTarea.ActivityDate :: ' + inTask.ActivityDate);
	            	//System.debug('TaskMethods.CerrarTarea.Account.Id :: ' + inTask.WhatId.Account.ParentId);
					System.debug('TaskMethods.CerrarTarea.Id :: ' + inTask.Id);
                    
	            	System.debug('veamos.. ->'+((Account)inTask.What).Parent.Fecha_ultima_actividad_mas_reciente__c);
                    //Fecha_ultima_actividad_mas_reciente__c

					System.debug('ENTRA');

	            }
	        }

	        update listAcUpdate;


			//for(Task inTask : listTaskType){
				//SI Status = Completado, ParentId de Account != null, fecha ultima actividad de account < activitydate de tarea
				//System.debug('TaskMethods.CerrarTarea.listTaskType :: ' + inTask.ParentId);


				//if((mapAccount.get(inTask.WhatId).ParentId!=null) && (mapAccount.get(inTask.WhatId).Fecha_ultima_actividad_mas_reciente__c < inTask.ActivityDate)){
					//actualizar fecha
				//	mapAccount.get(inTask.WhatId).Fecha_ultima_actividad_mas_reciente__c = inTask.ActivityDate;
				//	listAccountUpdate.add(mapAccount.get(inTask.WhatId));
				//}
				
			//}
			//update listAccountUpdate;

		}

	}



	public static void CerrarTarea2 (List<Task> listTask) {
		
		if(!listTask.isEmpty()){

			//MAPAS DE CUENTAS Y OPORTUNIDADES
			Map<String, Account> mapAllAccounts = new Map<String, Account>([SELECT Id FROM Account]);
			Map<String, Opportunity> mapAllOportunities = new Map<String, Opportunity>([SELECT Id FROM Opportunity]);

			//LISTAS A ACTUALIZAR
			List<Account> listAccountUpdate = new List<Account>();
			List<Opportunity> listOpportunityUpdate = new List<Opportunity>();

			//CREAR MAPAS CON LOS DATOS PARA ACTUALIZAR
			Set<String> listAccountIds = new Set<String> ();
			Set<String> listOpportunityIds = new Set<String> ();


			for (Task inTask : listTask) {

				System.debug(inTask);

				if(inTask.Status == 'Completed'){
					if(mapAllAccounts.get(inTask.WhatId)  != null){
						//Si el whatid de task coincide con algun id de la lista de cuentas
						listAccountIds.add(inTask.WhatId);
					} else if(mapAllOportunities.get(inTask.WhatId)  != null){
						listOpportunityIds.add(inTask.WhatId);
					}
				}
			}

			System.debug(listOpportunityIds);

			/////////////////////////
			Map<String, Account> mapAccountPrueba = new Map<String, Account>([SELECT Id, Fecha_ultima_actividad_mas_reciente__c, ParentId FROM Account WHERE id IN : listAccountIds AND Id IN (SELECT AccountId FROM Opportunity WHERE id IN : listOpportunityIds)]);
			/////////////////////////
			//https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_relationships_query_using.htm




			//ACTUALIZAR OPORTUNIDADES
			Map<String, Opportunity> mapOportunity = new Map<String, Opportunity>([SELECT Id, AccountId FROM Opportunity WHERE id IN : listOpportunityIds]);

			//sacar sus cuentas y actualizarlas(pasarlas abajo?)
			for(String idOportunity : listOpportunityIds){
				listAccountIds.add(mapOportunity.get(idOportunity).AccountId);

			}


			//ACTUALIZAR CUENTAS
			Map<String, Account> mapAccount = new Map<String, Account>([SELECT Id, Fecha_ultima_actividad_mas_reciente__c, ParentId FROM Account WHERE id IN : listAccountIds]);

			System.debug('TaskMethods.CerrarTarea.mapAccount :: ' + mapAccount);

			//RECORRER TAREAS ****
			for(Task inTask : listTask){
				System.debug('TaskMethods.CerrarTarea.inTask :: ' + inTask);
				//SI Status = Completado, ParentId de Account != null, fecha ultima actividad de account < activitydate de tarea
				if((mapAccount.get(inTask.WhatId).ParentId!=null) && (mapAccount.get(inTask.WhatId).Fecha_ultima_actividad_mas_reciente__c < inTask.ActivityDate)){
					//actualizar fecha
					mapAccount.get(inTask.WhatId).Fecha_ultima_actividad_mas_reciente__c = inTask.ActivityDate;
					listAccountUpdate.add(mapAccount.get(inTask.WhatId));
				}
				
			}
			update listAccountUpdate;
		}
	}
}