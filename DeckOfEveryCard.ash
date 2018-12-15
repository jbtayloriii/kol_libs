import wp_lib/UrlBuilder;

int DECK_CHOICE_WHEEL_OF_FORTUNE = 67;
int DECK_CHOICE_1952_CARD = 58;
int DECK_CHOICE_GIANT_GROWTH = 39; 
int DECK_CHOICE_ANCESTRAL_RECALL = 40; 
int DECK_CHOICE_ISLAND = 35;
int DECK_CHOICE_FOREST = 34;
int DECK_CHOICE_GIFT_CARD = 41;

string URL_DECK_USE = urlBuilder("inv_use.php")
	.addParam("cheat", 1)
	.addParam("whichitem", 8382)
	.addPasswordParam()
	.build();

void cheatDeck(int deckChoice) {
	visit_url(URL_DECK_USE);
	
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1086)
		.addParam("option", 1)
		.addParam("which", deckChoice)
		.addPasswordParam()
		.build());

	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1085)
		.addParam("option", 1)
		.addPasswordParam()
		.build());
}