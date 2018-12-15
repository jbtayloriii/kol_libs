import wp_lib/UrlBuilder.ash;

int BASTILLE_BATTALION_CONTROL_RIG_ID = 9928;

string [stat] STAT_MODES;
STAT_MODES[$stat[muscle]] = "Barbican set to BABAR mode";
STAT_MODES[$stat[mysticality]] = "Barbican set to BARBARIAN BARBECUE mode";
STAT_MODES[$stat[moxie]] = "Barbican set to BARBERSHOP mode";

item BRUTAL_BROGUES = $item[9929];
item DRAFTSMAN_DRIVING_GLOVES = $item[9930];
item NOUVEAU_NOSERING = $item[9931];

string [item] ACCESSORY_MODES;
ACCESSORY_MODES[BRUTAL_BROGUES] = "Drawbridge style: BRUTALIST";
ACCESSORY_MODES[DRAFTSMAN_DRIVING_GLOVES] = "Drawbridge style: DRAFTSMAN";
ACCESSORY_MODES[NOUVEAU_NOSERING] = "Drawbridge style: ART NOUVEAU";

string [stat] BUFF_MODES;
BUFF_MODES[$stat[muscle]] = "Murder hole size: CANNON";
BUFF_MODES[$stat[mysticality]] = "Murder hole size: CATAPULT";
BUFF_MODES[$stat[moxie]] = "Murder hole size: GESTURE";

string MAINSTAT_SELECTOR = urlBuilder(URL_CHOICE)
	.addParam("whichchoice", 1313)
	.addParam("option", 1)
	.addPasswordParam()
	.toString();

string ACCESSORY_SELECTOR = urlBuilder(URL_CHOICE)
	.addParam("whichchoice", 1313)
	.addParam("option", 2)
	.addPasswordParam()
	.toString();

string BUFF_SELECTOR = urlBuilder(URL_CHOICE)
	.addParam("whichchoice", 1313)
	.addParam("option", 3)
	.addPasswordParam()
	.toString();

string ENTER_BASTILLE_INTERFACE = urlBuilder("inv_use.php")
	.addParam("which", 3)
	.addParam("whichitem", BASTILLE_BATTALION_CONTROL_RIG_ID)
	.addPasswordParam()
	.toString();

string START_BASTILLE_GAME = urlBuilder(URL_CHOICE)
	.addParam("whichchoice", 1313)
	.addParam("option", 5)
	.addPasswordParam()
	.toString();

string GAME_MASTER_OF_NONE = urlBuilder(URL_CHOICE)
	.addParam("whichchoice", 1314)
	.addParam("option", 1)
	.addPasswordParam()
	.toString();

string GAME_HELLO_TO_ARMS = urlBuilder(URL_CHOICE)
	.addParam("whichchoice", 1317)
	.addParam("option", 1)
	.addPasswordParam()
	.toString();


string GAME_CASTLE_TO_CASTLE = urlBuilder(URL_CHOICE)
	.addParam("whichchoice", 1315)
	.addParam("option", 1)
	.addPasswordParam()
	.toString();

string GAME_LOCK_IN_SCORE = urlBuilder(URL_CHOICE)
	.addParam("whichchoice", 1316)
	.addParam("option", 1)
	.addPasswordParam()
	.toString();

void setBastilleBuffOption(stat buffstat) {
	if (!(BUFF_MODES contains buffstat)) {
		abort("Invalid buff stat selected for Bastille Battalion");
	}

	for i from 0 to 2 {
		buffer page = visit_url(BUFF_SELECTOR);
		if (page.contains_text(BUFF_MODES[buffstat])) {
			return;
		}
	}
}

void setBastilleAccessoryOption(item acc) {
	if (!(ACCESSORY_MODES contains acc)) {
		abort("Illegal accessory chosen for Bastille Battalion");
	}

	for i from 0 to 2 {
		buffer page = visit_url(ACCESSORY_SELECTOR);
		if (page.contains_text(ACCESSORY_MODES[acc])) {
			return;
		}
	}

	abort("Unable to set accessory for Bastille Battalion");
}

void setBastilleStatOption(stat mainstat) {
	for i from 0 to 2 {
		buffer page = visit_url(MAINSTAT_SELECTOR);
		if (page.contains_text(STAT_MODES[mainstat])) {
			return;
		}
	}
	abort("Unable to set mainstat for Bastille Battalion");
}

void playGame() {
	buffer page = visit_url(START_BASTILLE_GAME);
	while( !page.contains_text("whichchoice value=1316")) {
		if (page.contains_text("whichchoice value=1314")) {
			page = visit_url(GAME_MASTER_OF_NONE);
		} else if (page.contains_text("whichchoice value=1315")) {
			page = visit_url(GAME_CASTLE_TO_CASTLE);
		} else if (page.contains_text("whichchoice value=1317")) {
			page = visit_url(GAME_HELLO_TO_ARMS);
		} else {
			abort("Invalid page found during bastille battalion game");
		}
	}

	visit_url(GAME_LOCK_IN_SCORE);
}

void useBastilleBattalion(stat mainstat, item acc, stat buffstat) {
	visit_url(ENTER_BASTILLE_INTERFACE);
	setBastilleStatOption(mainstat);
	setBastilleAccessoryOption(acc);
	setBastilleBuffOption(buffstat);

	playGame();

	//	TODO: Play the game, exit bastille
}

// TODO: Remove this
// TODO: Actually play the game and get the buffs
void main() {
	//useBastilleBattalion($stat[mysticality], DRAFTSMAN_DRIVING_GLOVES, $stat[mysticality]);
	buffer page = visit_url(GAME_LOCK_IN_SCORE);
	print(page);
}