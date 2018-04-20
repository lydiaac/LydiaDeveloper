@isTest
private class AccountTest {

	@isTest static void ActualizarCuentaHija() {

		Account oAccountParent = new Account(Name='CuentaParent', 
											Fecha_ultima_actividad_mas_reciente__c=Date.newInstance(2020, 1, 11));
		insert oAccountParent;

		Account oAccountChild = new Account(Name='CuentaChild', 
										ParentId=oAccountParent.Id, 
										Fecha_ultima_actividad_mas_reciente__c=Date.newInstance(2018, 1, 11));

		insert oAccountChild;

		System.debug('PARENT :: ' + oAccountParent);
		System.debug('CHILD :: ' + oAccountChild);

		oAccountParent.Fecha_ultima_actividad_mas_reciente__c = Date.newInstance(2022, 1, 11);

		update oAccountParent;

		System.debug('PARENT :: ' + oAccountParent);

		Account oAccountChildCheck = [SELECT Fecha_ultima_actividad_mas_reciente__c FROM Account WHERE Id = :oAccountChild.Id];
	
		System.debug('CHILD CHECK :: ' + oAccountChildCheck);

		System.assertEquals(oAccountChildCheck.Fecha_ultima_actividad_mas_reciente__c, oAccountParent.Fecha_ultima_actividad_mas_reciente__c);

	}
}