
boolean [item] VIP_FLOUNDRY_ITEMS = $items[Carpe, Codpiece, Troutsers, Bass Clarinet, Fish Hatchet, Tunac];

int VIP_DECK_MYST_SUBSTAT = 14;
int VIP_DECK_FOREST = 33;
int VIP_DECK_GIANT_GROWTH = 38;
int VIP_DECK_AUTOSELL = 64;

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
 *******************************/

record pantogram_sacrifice {
	int sacId;
	item sacItem;
	int sacCount;
};

int [stat] PANTOGRAM_STATS;
PANTOGRAM_STATS[$stat[muscle]] = 1;
PANTOGRAM_STATS[$stat[mysticality]] = 2;
PANTOGRAM_STATS[$stat[moxie]] = 3;

int [element] PANTOGRAM_ELEMENTS;
PANTOGRAM_ELEMENTS[$element[hot]] = 1;
PANTOGRAM_ELEMENTS[$element[cold]] = 2;
PANTOGRAM_ELEMENTS[$element[spooky]] = 3;
PANTOGRAM_ELEMENTS[$element[sleaze]] = 4;
PANTOGRAM_ELEMENTS[$element[stench]] = 5;

int PANTOGRAM_SAC_HP_UP = 1;
int PANTOGRAM_SAC_MP_UP = 2;
int PANTOGRAM_SAC_HP_REGEN_LOW = 3;
int PANTOGRAM_SAC_HP_REGEN_MED = 4;
int PANTOGRAM_SAC_HP_REGEN_HIGH = 5;
int PANTOGRAM_SAC_MP_REGEN_LOW = 6;
int PANTOGRAM_SAC_MP_REGEN_MED = 7;
int PANTOGRAM_SAC_MP_REGEN_HIGH = 8;
int PANTOGRAM_SAC_MP_SKILLS = 9;
pantogram_sacrifice [int] PANTOGRAM_SACRIFICE_1;

pantogram_sacrifice test_rec;
test_rec.sacId = -1;
test_rec.sacItem = $item[none];
test_rec.sacCount = 0;

PANTOGRAM_SACRIFICE_1[PANTOGRAM_SAC_HP_UP] = test_rec;



pantogram_sacrifice [int] PANTOGRAM_SACRIFICE_2;
pantogram_sacrifice [int] PANTOGRAM_SACRIFICE_3;


boolean vip_pantogram_summon(stat st, element el, int sac_1, int sac_2, int sac_3) {
	if (item_amount($item[9573]) == 0) {
		abort("vip_pantogram_summon: No pantogram in inventory");
	}
	if (!(PANTOGRAM_STATS contains st)) {
		abort("vip_pantogram_summon: Invalid mainstat selected");
	}
	if (!(PANTOGRAM_ELEMENTS contains el)) {
		abort("vip_pantogram_summon: Invalid element selected");
	}
	
	int stId = PANTOGRAM_STATS[st];
	int elId = PANTOGRAM_ELEMENTS[el];
	
	#use(1, $item[9573]);
	visit_url("inv_use.php?pwd&whichitem=9573");
	visit_url("choice.php?whichchoice=1270&pwd&option=1&m=" + stId + "&e=" + elId + "&s1=-1%2C0&s2=-2%2C0&s3=-1%2C0",true,true);
	return true;
}
