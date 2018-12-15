import wp_lib/UrlBuilder.ash;

void boxingDaydream() {
	print("TODO: Implement boxingDaydream");
}

void boxingDaySpa(int spaTrip) {
	print("TODO: Implement boxing day spa");
}


// Testing voting booth
void main() {
	string url = urlBuilder("choice.php")
		.addParam("whichchoice", 1331)
		.addParam("g", 1)
		.addParam("option", "1")
		.addParam("local[]", "1")
		.addPasswordParam()
		.toString();
	print(visit_url(url));
}