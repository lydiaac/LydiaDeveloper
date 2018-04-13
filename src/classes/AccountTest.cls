@isTest
private class AccountTest {

	@isTest static void ActualizarCuentaHija() {

		Account oAccountParent = new Account(Name='CuentaParent');
		insert oAccountParent;

		Account oAccountChild = new Account(Name='Cuenta', 
										ParentId=oAccountParent.Id, 
										Fecha_ltima_actividad_m_s_reciente__c=Date.newInstance(2018, 1, 11));

		insert oAccountChild;

		oAccountParent.Fecha_ltima_actividad_m_s_reciente__c = Date.newInstance(2020, 1, 11);

		update oAccountParent;

		Account oAccountChildCheck = [SELECT Fecha_ltima_actividad_m_s_reciente__c FROM Account WHERE Id = :oAccountChild.Id];
	
		System.assertEquals(oAccountChildCheck.Fecha_ltima_actividad_m_s_reciente__c, oAccountParent.Fecha_ltima_actividad_m_s_reciente__c);

	}
}