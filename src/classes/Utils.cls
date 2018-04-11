public with sharing class Utils {
	
	public static boolean isNifNie(String nif){

		System.debug('NIF '+nif);
		   //si es NIE, eliminar la x,y,z inicial para tratarlo como nif
		if (nif.toUpperCase().startsWith('X')||nif.toUpperCase().startsWith('Y')||nif.toUpperCase().startsWith('Z')){
			nif = nif.substring(1);
		}
		 
		Pattern nifPattern = Pattern.compile('(\\d{1,8})([TRWAGMYFPDXBNJZSQVHLCKEtrwagmyfpdxbnjzsqvhlcke])');
		Matcher m = nifPattern.matcher(nif);
		if(m.matches()){
			String letra = m.group(2);
			//Extraer letra del NIF
			String letras = 'TRWAGMYFPDXBNJZSQVHLCKE';
			Integer dni = Integer.valueOf(m.group(1));
			dni = math.mod(dni,23);
			//dni = dni % 23;
			String reference = letras.substring(dni,dni+1);
			 
			if (reference.equalsIgnoreCase(letra)){
				System.debug('son iguales. Es NIF. '+letra+' '+reference);
				return true;
			}else{
				System.debug('NO son iguales. NO es NIF. '+letra+' '+reference);
				return false;
			}
		} else {
			return false;
		}
	}
}