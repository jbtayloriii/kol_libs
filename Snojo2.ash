import wp_lib/UrlBuilder.ash;

// TODO: Figure out why mafia won't let me run this file as Snojo.ash

int [stat] STAT_CHOICES;
STAT_CHOICES[$stat[muscle]] = 1;
STAT_CHOICES[$stat[mysticality]] = 2;
STAT_CHOICES[$stat[moxie]] = 3;

void changeSnojoStat(stat newStat) {
	if (!(STAT_CHOICES contains newStat)) {
		abort("Invalid stat choice for snojo");	
	}

	string url = urlBuilder("choice.php")
		.addParam("whichchoice", 1118)
		.addParam("option", STAT_CHOICES[newStat])
		.addPasswordParam()
		.toString();

	visit_url(urlBuilder("place.php")
		.addParam("whichplace", "snojo")
		.addParam("action", "snojo_controller")
		.toString());

	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1118)
		.addParam("option", STAT_CHOICES[newStat])
		.addPasswordParam()
		.toString());
}

void main() {
	changeSnojoStat($stat[muscle]);
}