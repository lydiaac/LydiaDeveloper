public class ContactAndLeadSearch {

    public static List<List<sObject>> searchContactsAndLeads(String Srchstring)
    {
        List<List<sObject>> SrcList=[Find :Srchstring IN all FIELDS  returning Contact(Firstname,LastName), Lead(Firstname,LastName)];
        return SrcList;
    }
}