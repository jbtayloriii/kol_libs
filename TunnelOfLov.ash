import UrlBuilder.ash;

int LOV_EQUIPMENT_CARDIGAN = 1;
int LOV_EQUIPMENT_EPAULETTES = 2;
int LOV_EQUIPMENT_EARRINGS = 3;

int LOV_BUFF_STATS = 1;
int LOV_BUFF_FAMILIAR_WEIGHT = 2;
int LOV_BUFF_ITEM_DROPS = 3;

int LOV_ITEM_BOOMERANG = 1;
int LOV_ITEM_TOY_DART_GUN = 2;
int LOV_ITEM_CHOCOLATE = 3;
int LOV_ITEM_FLOWERS = 4;
int LOV_ITEM_ELEPHANT = 5;
int LOV_ITEM_TOAST = 6;


string VISIT_TUNNEL = urlBuilder("place.php")
	.addParam("whichplace", "town_wrong")
	.addParam("action", "townwrong_tunnel")
	.build();

string ENTER_TUNNEL = urlBuilder("choice.php")
	.addParam("whichchoice", 1222)
	.addParam("option", 1)
	.addPasswordParam()
	.build();

string FIGHT_ENFORCER = urlBuilder("choice.php")
	.addParam("whichchoice", 1223)
	.addParam("option", 1)
	.addPasswordParam()
	.build();

string FIGHT_ENGINEER = urlBuilder("choice.php")
	.addParam("whichchoice", 1225)
	.addParam("option", 1)
	.addPasswordParam()
	.build();

string FIGHT_EQUIVOCATOR = urlBuilder("choice.php")
	.addParam("whichchoice", 1227)
	.addParam("option", 1)
	.addPasswordParam()
	.build();

void enterTunnelOfLov(int equipmentChoice, int buffChoice, int itemChoice, string fightScript) {
	visit_url(VISIT_TUNNEL);
	visit_url(ENTER_TUNNEL);

	visit_url(FIGHT_ENFORCER);
	run_combat(fightScript);
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1224)
		.addParam("option", equipmentChoice)
		.addPasswordParam()
		.build());

	visit_url(FIGHT_ENGINEER);
	run_combat(fightScript);
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1226)
		.addParam("option", buffChoice)
		.addPasswordParam()
		.build());

	visit_url(FIGHT_EQUIVOCATOR);
	run_combat(fightScript);
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1228)
		.addParam("option", itemChoice)
		.addPasswordParam()
		.build());
}