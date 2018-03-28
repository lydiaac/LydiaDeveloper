@isTest
private class TestVerifyDate {

	@isTest static void testDateWithin30Days() {
		Date d1 = Date.newInstance(2018, 1, 21);
		Date d2 = Date.newInstance(2018, 1, 22);
		Date fecha = VerifyDate.CheckDates(d1, d2);
        System.assertEquals(d2, fecha);
    }

    @isTest static void testSetEndOfMonthDate() {
    	Date d1 = Date.newInstance(2018, 1, 21);
    	Date d2 = Date.newInstance(2018, 1, 20);
    	Date fecha = VerifyDate.CheckDates(d1, d2);
    	System.assertEquals(Date.newInstance(2018, 1, 31),fecha);
    }
}