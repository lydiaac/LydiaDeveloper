public with sharing class CreateContactFromCan {
        
    //Declare a method that does not return anything and takes one input parameter of a Candidate list object called candsFromTrigger
    public void createContact (List<Candidate__c> candsFromTrigger){
        
        //Instantiate a Contact list object from the List class 
        List<Contact> conList = new List<Contact>();

        //Declare a For list loop to loop through the input parameter list candsFromTrigger with an iteration variable called currentCandidate
        for(Candidate__c currentCandidate:candsFromTrigger){
                
        }
    }
}