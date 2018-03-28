public class ContactSearch {

	//Devolver el resultado de una consulta

	public static List<Contact> searchForContacts (string apellido, string cp) {

		List<Contact> contacts = [SELECT ID, Name
									FROM Contact
									WHERE LastName =: apellido AND MailingPostalCode =: cp];

		return contacts;
	}
}