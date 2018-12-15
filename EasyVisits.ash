import UrlBuilder.ash;

void visitTootOriole() {
	visit_url(urlBuilder("tutorial.php")
		.addParam("action", "toot")
		.build());
}

// TODO: add the extra free adventure for the dialog here
void unlockSkeletonStore() {
	visit_url(urlBuilder("shop.php")
		.addParam("whichshop", "meatsmith")
		.addParam("action", "talk")
		.build());
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1059)
		.addParam("option", 1)
		.addPasswordParam()
		.build());
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1059)
		.addParam("option", 3)
		.addPasswordParam()
		.build());
}