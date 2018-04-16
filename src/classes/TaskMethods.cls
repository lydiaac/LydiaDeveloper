public with sharing class TaskMethods {

	public static void CerrarTarea (List<Task> listTask, Map<Id,Task> mapTaskOld) {
		
		if(!listTask.isEmpty()){

			//Lista de los ids de las tareas cambiadas a 'Completed'

			Set<String> setTaskIds = new Set<String> ();

			for (Task inTask : listTask) {
				if(mapTaskOld.get(inTask.Id).Status != 'Completed' && inTask.Status == 'Completed'){
					setTaskIds.add(inTask.Id);
				}
			}

			//Lista de tareas con las cuentas padre

			List<Task> listTaskType = new List<Task>([
			SELECT WhatId, ParentId,
			  TYPEOF What
			  	WHEN Opportunity THEN Account.ParentId, 
			    WHEN Account THEN ParentId
			  END
			FROM Task WHERE Id IN : setTaskIds]);

			System.debug('TaskMethods.CerrarTarea.listTaskType :: ' + listTaskType);

			for(Task inTask : listTaskType){
				//if (inTask.WhatId instanceof Opportunity) {
				//	System.debug('Opportunity');
	                //User userOwner = merch.Owner;
	                //processUser(userOwner);
	            //} else if (inTask.WhatId instanceof Account) {
	            //	System.debug('Account');
	                //Group groupOwner = merch.Owner;
	                //processGroup(groupOwner);
	            //}
	        }


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