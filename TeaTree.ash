import UrlBuilder.ash;

item IT_SOBRIE_TEA = $item[8634];

boolean [item] TEA_TREE_ITEM_OPTIONS;
TEA_TREE_ITEM_OPTIONS[IT_SOBRIE_TEA] = true;

string PICK_URL = urlBuilder("choice.php")
	.addParam("whichchoice", 1104)
	.addParam("option", 2)
	.addPasswordParam()
	.build();

void pickTeaTree(item itChoice) {
	if (!(TEA_TREE_ITEM_OPTIONS contains itChoice)) {
		abort("Invalid tea tree item choice.");
	}

	visit_url(PICK_URL);
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1105)
		.addParam("option", 1)
		.addParam("itemid", itChoice.to_int())
		.addPasswordParam()
		.build());	
}