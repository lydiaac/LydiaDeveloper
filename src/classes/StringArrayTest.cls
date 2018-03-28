public with sharing class StringArrayTest {

	//Devolver una lista de Strings

	public static List<String> generateStringArray (Integer numeroStrings) {
		List<String> tests = new List<String>();
		for(Integer i=0; i<numeroStrings;i++) {
			tests.add('Test ' + i);
		}
		return tests;
	}
	
}