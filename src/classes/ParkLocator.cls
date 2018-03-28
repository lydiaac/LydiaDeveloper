public class ParkLocator {

	//A partir de introducir un pais, sacar una lista con sus parques{
    public  static string[] country(String country) {
        ParkService.ParksImplPort prk = new ParkService.ParksImplPort();
        return prk.byCountry(country);
    }

}