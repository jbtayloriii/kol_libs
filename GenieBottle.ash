import UrlBuilder.ash

item GENIE_BOTTLE = $item[9529];

string POCKET_WISH = "for more wishes";

string getWishUrl(string wish) {
	return urlBuilder("choice.php")
		.addParam("option", 1)
		.addParam("whichchoice", 1267)
		.addParam("wish", wish)
		.addPasswordParam()
		.toString();
}

boolean getRemainingGeniePocketWishes() {
	if (item_amount(GENIE_BOTTLE) == 0) {
		abort("vip_genie_get_wishes: No genie bottle in inventory");
	}

	visit_url(urlBuilder("inv_use.php")
		.addParam("whichitem", 9529)
		.addParam("which", 3)
		.addPasswordParam()
		.build());

	string wish = "for more wishes";
	buffer page = visit_url(getWishUrl(wish));

	while(page.index_of("You have no wishes left") > -1) {
		visit_url(urlBuilder("inv_use.php")
			.addParam("whichitem", 9529)
			.addParam("which", 3)
			.addPasswordParam()
			.build());
		
		page = visit_url(getWishUrl(wish));
	}

	return true;
}