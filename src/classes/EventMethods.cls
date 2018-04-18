public with sharing class EventMethods {
	
	public static void CrearEvento (List<Event> listEvent) {
		
		if(!listEvent.isEmpty()){

			List<Account> listAcInsert = new List<Account>();

			Set<String> setEventIds = new Set<String> ();

			for (Event inEvent : listEvent) {
				System.debug('EventMethods.CrearEvento.inEvent :: ' + inEvent);
				setEventIds.add(inEvent.Id);
			}

			System.debug('EventMethods.CrearEvento.setEventIds :: ' + setEventIds);

			//Lista de tareas
			List<Event> listEventType = new List<Event>([
			SELECT WhatId, ActivityDate,
			  	TYPEOF What
			  	WHEN Account THEN Parent.Fecha_ultima_actividad_mas_reciente__c
			  	WHEN Opportunity THEN Account.Parent.Fecha_ultima_actividad_mas_reciente__c
			  	END
			FROM Event WHERE Id IN : setEventIds]);

			System.debug('EventMethods.CrearEvento.listEventType :: ' + listEventType);

			//Dependiendo si recibe account u oportunity...
			for(Event inEvent : listEventType){
				if (inEvent.What instanceof Opportunity) {
					System.debug('Opportunity');
					if(inEvent.ActivityDate > ((Opportunity)inEvent.What).Account.Parent.Fecha_ultima_actividad_mas_reciente__c){
						((Opportunity)inEvent.What).Account.Parent.Fecha_ultima_actividad_mas_reciente__c = inEvent.ActivityDate;
						listAcInsert.add(((Opportunity)inEvent.What).Account.Parent);
					}
	            } else if (inEvent.What instanceof Account) {
	            	System.debug('Account');
	            	//System.debug('veamos.. ->'+((Account)inTask.What).Parent.Fecha_ultima_actividad_mas_reciente__c);
					if(inEvent.ActivityDate > ((Account)inEvent.What).Parent.Fecha_ultima_actividad_mas_reciente__c){
						((Account)inEvent.What).Parent.Fecha_ultima_actividad_mas_reciente__c = inEvent.ActivityDate;
						listAcInsert.add(((Account)inEvent.What).Parent);
					}
	            }
	        }
			update listAcInsert;
		}
	}
}