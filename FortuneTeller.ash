import UrlBuilder.ash;

INT FORTUNE_FAMILAR_BUFF = -1;
INT FORTUNE_ITEM_BUFF = -2;
INT FORTUNE_MEAT_BUFF = -3;
INT FORTUNE_MUSCLE_BUFF = -4;
INT FORTUNE_MYSTICALITY_BUFF = -5;
INT FORTUNE_MOXIE_BUFF = -6;

string FORTUNE_TELLER_LOCATION = urlBuilder("clan_viplounge")
	.addParam("preaction", "lovetester")
	.build();

void getFortuneTellerBuff(int buffChoice) {
	visit_url(FORTUNE_TELLER_LOCATION);
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1278)
		.addParam("option", 1)
		.addParam("which", buffChoice)
		.addParam("q1", "tacos")
		.addParam("q2", "tilde")
		.addParam("q3", "test")
		.addPasswordParam()
		.build());
}
