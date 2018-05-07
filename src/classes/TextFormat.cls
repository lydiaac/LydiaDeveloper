public with sharing class TextFormat {

	public static String textFormat(String texto) {

		String textoFinal = '';

		//String texto = '§Fyrfadslys # [optional bzw. nur für Handzettel] # Brænder i ca. 8 timer # RAL-kvalitet: gode brændeegenskaber pga. kvalitetskontrollerede materialer og indholdsstoffer # [Nur für RO|GR] # Materiale: 60% plantevoks, 40% paraffin # [alle] # [Lieferantenadresse für Bulgarien? Mueller Fabryka Swiec S.A. | 86-302 Grudziadz, Bialy Bór | Polska§';
		
		if(texto != null){
        	if(!texto.contains('<ul>') || (!texto.contains('</'))){                    
        		if((texto.indexOF('§') == 0) && (texto.indexOF('§',1) == texto.length() - 1)){

					String textoUl = texto.remove('§');

					System.debug(textoUl);

					List<String> partes = textoUl.split('#');

					for(String stg : partes){
					    textoFinal += '<li>' + stg + '</li>';
					}

					textoFinal = '<ul>' + textoFinal + '</ul>';
					System.debug(textoFinal);  
				}
			}
		}

		return textoFinal;
	}
}