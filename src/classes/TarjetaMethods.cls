public with sharing class TarjetaMethods {

	public static void CrearOportunidad (List<Tarjeta_de_cr_dito__c> listTarjetas) {
		
		if(!listTarjetas.isEmpty()){

			List<Opportunity> listOpToInsert = new List<Opportunity>();

			User userAborda = [SELECT Alias FROM User WHERE Alias = 'test' LIMIT 1];

			//MAP CONTACT
			Set<String> listContactIds = new Set<String> ();
			for (Tarjeta_de_cr_dito__c inTarjeta : listTarjetas) {
				listContactIds.add(inTarjeta.Contacto__c);
			}

			Map<String, Contact> mapContact = new Map<String, Contact>([SELECT Id, Premium__c, Name, AccountId FROM Contact WHERE id IN : listContactIds]);

			//RECORRER TARJETAS y crear oportunidad
			for(Tarjeta_de_cr_dito__c inTarjeta : listTarjetas){
				if((inTarjeta.OwnerId == userAborda.Id) && (mapContact.get(inTarjeta.Contacto__c).Premium__c == True)){
					Opportunity oOpportunity = new Opportunity();
					oOpportunity.Name=mapContact.get(inTarjeta.Contacto__c).Name;
					oOpportunity.CloseDate=Date.newInstance((Integer)inTarjeta.A_o_caducidad__c, 01, (Integer)inTarjeta.Mes_de_caducidad__c);//YY/DD/MM
					oOpportunity.StageName='No iniciado';
					oOpportunity.AccountId=mapContact.get(inTarjeta.Contacto__c).AccountId;
					listOpToInsert.add(oOpportunity);
				}
			}
			insert listOpToInsert;
		}

	}

	public static void CrearOportunidadDos (List<Tarjeta_de_cr_dito__c> listNews) {
        List<Opportunity> listOpToInsert = new List<Opportunity>();
        
        if(!listNews.isEmpty()){
            User userAborda = [SELECT Alias FROM User WHERE Alias = 'taborda' LIMIT 1];
            System.debug('TarjetaMethods.CrearOportunidad :: userAborda ' + userAborda);
            Set<Id> setContactId = new Set<Id>();
            Map<Id, List<Tarjeta_de_cr_dito__c>> mapContactIdTarjetas = new Map<Id, List<Tarjeta_de_cr_dito__c>>();
            
            //Recorro todas las nuevas tarjetas del trigger y con las que cumplan la condicion las meto en un mapa con el ID del Contacto como clave
            //Como puede existir mas de una tarjeta para un usuario el mapa sera -> clave:Contacto // valor:listaTarjetas
            for(Tarjeta_de_cr_dito__c inTarjeta : listNews){
                
                if(inTarjeta.OwnerId == userAborda.Id){
                    List<Tarjeta_de_cr_dito__c> listTarjetas = new List<Tarjeta_de_cr_dito__c>();
                    //Debo chequear si ya existe la clave, en ese caso significa que se habia insertado antes otra u otras tarjetas 
                    //Por tanto debo recuperar la lista del mapa y añadir a esta la ultima tarjeta
                    if(mapContactIdTarjetas.containsKey(inTarjeta.Contacto__c)){
                        listTarjetas = mapContactIdTarjetas.get(inTarjeta.Contacto__c);
                    } 
                    listTarjetas.add(inTarjeta);
                    mapContactIdTarjetas.put(inTarjeta.Contacto__c, listTarjetas);
                }    
            }
            //Para todos los contactos premium cuyo id existe en el mapa recorro todas las tarjetas y creo una oportunidad
            for(Contact inContact : [SELECT Name, Premium__c, AccountId FROM Contact WHERE Id IN :mapContactIdTarjetas.KeySet() AND Premium__c = true]){
                for(Tarjeta_de_cr_dito__c inTarjeta : mapContactIdTarjetas.get(inContact.id) ){
                       Opportunity oOpportunity = new Opportunity(); //Fecha -> YY/DD/MM
                       oOpportunity.Name=inContact.Name;
                       oOpportunity.CloseDate=Date.newInstance((Integer)inTarjeta.A_o_caducidad__c, 01, (Integer)inTarjeta.Mes_de_caducidad__c);
                       oOpportunity.StageName='No iniciado';
                       oOpportunity.AccountId=inContact.AccountId;
                       System.debug('TarjetaMethods.CrearOportunidad :: oOpportunity ' + oOpportunity);
                       listOpToInsert.add(oOpportunity);
                }    
            
            }
        insert listOpToInsert;
        System.debug('TarjetaMethods.CrearOportunidad :: listOpToInsert ' + listOpToInsert);
        }
    }

}