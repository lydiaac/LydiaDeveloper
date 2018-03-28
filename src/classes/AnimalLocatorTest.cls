@isTest
private class AnimalLocatorTest {


	@isTest static  void testGetAnimalNameById() {





		// Set mock callout class 
	    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
	    // This causes a fake response to be sent
	    // from the class that implements HttpCalloutMock. 
	    //HttpResponse response = (HttpResponse)AnimalLocator.getAnimalNameById(0);

	    String actualValue = AnimalLocator.getAnimalNameById(0);

	    // Verify that the response received contains fake values
	    //String contentType = response.getHeader('Content-Type');
	    //System.assert(contentType == 'application/json');
	    //String actualValue = response.getBody();
	    //System.debug(response.getBody());
	    String expectedValue ='majestic badger';
	    System.assertEquals(actualValue, expectedValue);
	    //System.assertEquals(200, response.getStatusCode());

		
	}


}