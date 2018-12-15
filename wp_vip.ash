import lib/wp_vip_init.ash

boolean [item] VIP_FLOUNDRY_ITEMS = $items[Carpe, Codpiece, Troutsers, Bass Clarinet, Fish Hatchet, Tunac];

int VIP_DECK_MYST_SUBSTAT = 14;
int VIP_DECK_FOREST = 33;
int VIP_DECK_GIANT_GROWTH = 38;
int VIP_DECK_AUTOSELL = 64;

item VIP_KEY_ITEM = $item[3947];

//todo: new you club

//todo spacegate

//todo: robortender

//todo: heart-shaped crate

//todo:space planula

//todo: gingerbread

//todo: thanksgarden

//todo: lil' orphan

//todo: time-spinner

//todo: protonic

boolean vip_cheat_deck(int deckCheat) {
	if(deckCheat == VIP_DECK_MYST_SUBSTAT) {
		cli_execute("cheat stat mysticality");
	} else if(deckCheat == VIP_DECK_FOREST) {
		cli_execute("cheat Forest");
	} else if(deckCheat == VIP_DECK_AUTOSELL) {
		cli_execute("cheat 1952 Mickey Mantle");
		autosell(1, $item[1952 Mickey Mantle card]);
	}
	return true;
}

/**
 * Pulls the requested floundry item
 *
 * @return: 
 */

void testing_func() {
	
	print("testing!");
}

boolean vip_floundry(item fishItem) {
	int itemNumber = 0;
	
	if(VIP_FLOUNDRY_ITEMS contains fishItem) {
		itemNumber = to_int(fishItem);
	}
	
	if(itemNumber == 0) {
		return false;
	}
	//todo:check that we can get a floundry item
	visit_url("clan_viplounge.php?preaction=buyfloundryitem&whichitem=" + itemNumber);
	return true;
}

/*******************************
 * NOV 2017 - PORTABLE PANTOGRAM

int PANTOGRAM_SAC_HP_UP = 1;
int PANTOGRAM_SAC_MP_UP = 2;
int PANTOGRAM_SAC_HP_REGEN_LOW = 3;
int PANTOGRAM_SAC_HP_REGEN_MED = 4;
int PANTOGRAM_SAC_HP_REGEN_HIGH = 5;
int PANTOGRAM_SAC_MP_REGEN_LOW = 6;
int PANTOGRAM_SAC_MP_REGEN_MED = 7;
int PANTOGRAM_SAC_MP_REGEN_HIGH = 8;
int PANTOGRAM_SAC_MP_SKILLS = 9;

 *******************************/


pantogram_sacrifice [int] PANTOGRAM_SACRIFICE_2;
pantogram_sacrifice [int] PANTOGRAM_SACRIFICE_3;

boolean vip_pantogram_summon(stat st, element el, int sac_1, int sac_2, int sac_3) {
	if (item_amount($item[9573]) == 0) {
		abort("vip_pantogram_summon: No pantogram in inventory");
	}
	if (!(_PANTOGRAM_STATS contains st)) {
		abort("vip_pantogram_summon: Invalid mainstat selected");
	}
	if (!(_PANTOGRAM_ELEMENTS contains el)) {
		abort("vip_pantogram_summon: Invalid element selected");
	}
	int [3] sacArr;
	sacArr[0] = sac_1;
	sacArr[1] = sac_2;
	sacArr[2] = sac_3;
	
	if (!(_PANTOGRAM_SACRIFICE_1 contains sac_1)) {
		abort("vip_pantogram_summon: Invalid scarifice 1");
	}
	if (!(_PANTOGRAM_SACRIFICE_2 contains sac_2)) {
		abort("vip_pantogram_summon: Invalid scarifice 2");
	}
	if (!(_PANTOGRAM_SACRIFICE_3 contains sac_3)) {
		abort("vip_pantogram_summon: Invalid scarifice 3");
	}

	pantogram_sacrifice sacRec_1 = _PANTOGRAM_SACRIFICE_1[sac_1];
	pantogram_sacrifice sacRec_2 = _PANTOGRAM_SACRIFICE_2[sac_2];
	pantogram_sacrifice sacRec_3 = _PANTOGRAM_SACRIFICE_3[sac_3];
	#if(sacRec_1.sacId > 0 && item_amount($item[sacId]) < sacRec_1.sacCount) {
		
	#}
	
	int stId = _PANTOGRAM_STATS[st];
	int elId = _PANTOGRAM_ELEMENTS[el];
	
	#use(1, $item[9573]);
	visit_url("inv_use.php?pwd&whichitem=9573");
	visit_url("choice.php?whichchoice=1270&pwd&option=1&m=" + stId + "&e=" + elId + "&s1=-1%2C0&s2=-2%2C0&s3=-1%2C0",true,true);
	return true;
}

/*******************************
 * FEB 2018 - CLAN CARNIVAL GAME
 *******************************/

int FORTUNE_TELLER_BUFF_SUSIE = -1;
int FORTUNE_TELLER_BUFF_HAGNK = -2;
int FORTUNE_TELLER_BUFF_MEATSMITH = -3;
int FORTUNE_TELLER_BUFF_GUNTHER = -4;
int FORTUNE_TELLER_BUFF_GORGONZOLA = -5;
int FORTUNE_TELLER_BUFF_SHIFTY = -6;

boolean getNpcFortuneTellerBuff(int type) {
	if (type >= 0 || type < -6) {
		abort("getNpcFortuneTellerBuff: invalid buff id");
	}

	if (item_amount(VIP_KEY_ITEM) == 0) {
		abort("getNpcFortuneTellerBuff: No VIP access");
	}

	visit_url("clan_viplounge.php?preaction=lovetester");
		set_property("choiceAdventure1278","1");

	buffer page = visit_url("choice.php?whichchoice=1278&pwd&option=1&which=" + type + "&q1=beef&q2=bell&q3=loathing");
	if(page.index_of("You've already consulted Madame Zatara about your relationship with a resident of Seaside Town today") > -1) {
		return false;
	} else {
		return true;
	}
}



/*****************************
* OCTOBER 2018 - VOTER BOOTH
*****************************/


string VOTING_BOOTH_URL = "place.php?whichplace=town_right&action=townright_vote";

buffer votingBoothText() {
	return visit_url(VOTING_BOOTH_URL);
}