public with sharing class TaskMethods {

	public static void CerrarTarea (List<Task> listTask) {
		
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
				if(inTask.Status == 'Completed'){
					if(mapAllAccounts.get(inTask.WhatId)  != null){
						//Si el whatid de task coincide con algun id de la lista de cuentas
						listAccountIds.add(inTask.WhatId);
					} else if(mapAllOportunities.get(inTask.WhatId)  != null){
						listOpportunityIds.add(inTask.WhatId);
					}
				}
			}



			/////////////////////////
			Map<String, Account> mapAccountPrueba = new Map<String, Account>([SELECT Id, Fecha_ltima_actividad_m_s_reciente__c, ParentId FROM Account WHERE id IN : listAccountIds AND Id IN (SELECT AccountId FROM Opportunity WHERE id IN : listOpportunityIds)]);
			/////////////////////////
			//https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_relationships_query_using.htm




			//ACTUALIZAR OPORTUNIDADES
			Map<String, Opportunity> mapOportunity = new Map<String, Opportunity>([SELECT Id, AccountId FROM Opportunity WHERE id IN : listOpportunityIds]);

			//sacar sus cuentas y actualizarlas(pasarlas abajo?)
			for(String idOportunity : listOpportunityIds){
				listAccountIds.add(mapOportunity.get(idOportunity).AccountId);

			}


			//ACTUALIZAR CUENTAS
			Map<String, Account> mapAccount = new Map<String, Account>([SELECT Id, Fecha_ltima_actividad_m_s_reciente__c, ParentId FROM Account WHERE id IN : listAccountIds]);

			//RECORRER TAREAS
			for(Task inTask : listTask){
				//SI Status = Completado, ParentId de Account != null, fecha ultima actividad de account < activitydate de tarea
				if((mapAccount.get(inTask.WhatId).ParentId!=null) && (mapAccount.get(inTask.WhatId).Fecha_ltima_actividad_m_s_reciente__c < inTask.ActivityDate)){
					//actualizar fecha
					mapAccount.get(inTask.WhatId).Fecha_ltima_actividad_m_s_reciente__c = inTask.ActivityDate;
					listAccountUpdate.add(mapAccount.get(inTask.WhatId));
				}
				
			}
			update listAccountUpdate;
		}
	}
}