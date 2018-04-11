public with sharing class TarjetaMethods {

	public static void CrearOportunidad (List<Tarjeta_de_cr_dito__c> listTarjetas) {
		
		if(!listTarjetas.isEmpty()){

			for(Tarjeta_de_cr_dito__c inTarjeta : listTarjetas){



				//Opportunity oOpportunity3 = [SELECT Name, CloseDate, StageName, AccountId FROM Opportunity WHERE Id = '0061r00000vjlswAAA'];

				//System.debug('TarjetaMethods.CrearOportunidad :: oOpportunity3 ' + oOpportunity3);



				User userAborda = [SELECT Alias FROM User WHERE Alias = 'test' LIMIT 1];

				System.debug('TarjetaMethods.CrearOportunidad :: userAborda ' + userAborda);

				//Si el campo insertado es por Test Aborda -> Obtener contacto
				if(inTarjeta.OwnerId == userAborda.Id){
					
					Contact oContacto = [SELECT Name, Premium__c, AccountId FROM Contact WHERE Id = :inTarjeta.Contacto__c];

					System.debug('TarjetaMethods.CrearOportunidad :: oContacto ' + oContacto);

					//Si Contacto tiene Premium=True -> Crear oportunidad
					if(oContacto.Premium__c){

						Opportunity oOpportunity = new Opportunity (Name=oContacto.Name,
																	CloseDate=Date.newInstance((Integer)inTarjeta.A_o_caducidad__c, 01, (Integer)inTarjeta.Mes_de_caducidad__c),
																	StageName='No iniciado',
																	AccountId=oContacto.AccountId
																	); //Fecha -> YY/DD/MM

						System.debug('TarjetaMethods.CrearOportunidad :: oOpportunity ' + oOpportunity);

						insert oOpportunity;

						Opportunity oOpportunity2 = [SELECT Name, CloseDate, StageName, AccountId FROM Opportunity WHERE Id = :oOpportunity.Id];

						System.debug('TarjetaMethods.CrearOportunidad :: oOpportunity2 ' + oOpportunity2);
					}

				}

			}

		}

	}

}