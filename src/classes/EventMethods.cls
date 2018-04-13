public with sharing class EventMethods {
	
	public static void CrearEvento (List<Event> listEvent) {
		
		if(!listEvent.isEmpty()){

			List<Account> listAccountInsert = new List<Account>();

			//MAPA ACCOUNT
			Set<String> listAccountIds = new Set<String> ();
			for (Event inEvent : listEvent) {
				listAccountIds.add(inEvent.WhatId);
			}

			Map<String, Account> mapAccount = new Map<String, Account>([SELECT Id, Fecha_ltima_actividad_m_s_reciente__c, ParentId FROM Account WHERE id IN : listAccountIds]);

			//RECORRER EVENTOS
			for(Event inEvent : listEvent){
				//Si account tiene parent y su fecha es menor a la de Event
				if(inEvent.IsAllDayEvent && mapAccount.get(inEvent.WhatId).ParentId!=null && (mapAccount.get(inEvent.WhatId).Fecha_ltima_actividad_m_s_reciente__c < inEvent.ActivityDate)){
					mapAccount.get(inEvent.WhatId).Fecha_ltima_actividad_m_s_reciente__c = inEvent.ActivityDate;
					listAccountInsert.add(mapAccount.get(inEvent.WhatId));
				}
			}
			update listAccountInsert;
		}

	}
}