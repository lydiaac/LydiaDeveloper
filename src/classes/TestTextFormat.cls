@isTest
private class TestTextFormat {

	@isTest static void testTextFormat() {

		String texto = '§Fyrfadslys # [optional bzw. nur für Handzettel] # Brænder i ca. 8 timer # RAL-kvalitet: gode brændeegenskaber pga. kvalitetskontrollerede materialer og indholdsstoffer # [Nur für RO|GR] # Materiale: 60% plantevoks, 40% paraffin # [alle] # [Lieferantenadresse für Bulgarien? Mueller Fabryka Swiec S.A. | 86-302 Grudziadz, Bialy Bór | Polska§';
		
		String textoSalida = TextFormat.textFormat(texto);

		String textoFinal = '<ul><li>Fyrfadslys </li><li> [optional bzw. nur für Handzettel] </li><li> Brænder i ca. 8 timer </li><li> RAL-kvalitet: gode brændeegenskaber pga. kvalitetskontrollerede materialer og indholdsstoffer </li><li> [Nur für RO|GR] </li><li> Materiale: 60% plantevoks, 40% paraffin </li><li> [alle] </li><li> [Lieferantenadresse für Bulgarien? Mueller Fabryka Swiec S.A. | 86-302 Grudziadz, Bialy Bór | Polska</li></ul>';

		System.assertEquals(textoSalida.contains('<ul>'), true);
		System.assertEquals(textoSalida.contains('</ul>'), true);

		System.assertEquals(textoSalida.contains('<li>'), true);
		System.assertEquals(textoSalida.contains('</li>'), true);

		System.assertEquals(textoSalida.contains('§'), false);
		System.assertEquals(textoSalida.contains('#'), false);

		System.assertEquals(textoSalida, textoFinal);
	}

	@isTest static void testTextFormatNull() {

		String texto;

		String textoSalida = TextFormat.textFormat(texto);

		System.assertEquals(textoSalida, '');
	}

	@isTest static void testTextFormatEmpty() {

		String texto = '';

		String textoSalida = TextFormat.textFormat(texto);

		System.assertEquals(textoSalida, '');
	}

	@isTest static void testTextFormatNotGood() {

		String texto = 'Fyrfadslys # [optional bzw. nur für Handzettel] # Brænder i ca. 8 timer # RAL-kvalitet: gode brændeegenskaber pga. kvalitetskontrollerede materialer og indholdsstoffer # [Nur für RO|GR] # Materiale: 60% plantevoks, 40% paraffin # [alle] # [Lieferantenadresse für Bulgarien? Mueller Fabryka Swiec S.A. | 86-302 Grudziadz, Bialy Bór | Polska§';
		
		String textoSalida = TextFormat.textFormat(texto);

		System.assertEquals(textoSalida, '');

		String texto2 = '§§§§§§§§';
		
		String textoSalida2 = TextFormat.textFormat(texto2);

		System.assertEquals(textoSalida2, '');
	}

	@isTest static void testTextFormatGood() {

		String texto = '<ul><li>Fyrfadslys </li><li> [optional bzw. nur für Handzettel] </li><li> Brænder i ca. 8 timer </li><li> RAL-kvalitet: gode brændeegenskaber pga. kvalitetskontrollerede materialer og indholdsstoffer </li><li> [Nur für RO|GR] </li><li> Materiale: 60% plantevoks, 40% paraffin </li><li> [alle] </li><li> [Lieferantenadresse für Bulgarien? Mueller Fabryka Swiec S.A. | 86-302 Grudziadz, Bialy Bór | Polska</li></ul>';
		
		String textoSalida = TextFormat.textFormat(texto);

		System.assertEquals(textoSalida, '');
	}
}