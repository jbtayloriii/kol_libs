import woodpuzzleAdventure.ash
import woodpuzzleCombat.ash
import woodpuzzleVIP.ash
import UrlBuilder.ash
import TeaTree.ash
import GenieBottle.ash
import GarbageTote.ash
import DeckOfEveryCard.ash
import EasyVisits.ash

item ITEM_ASTRAL_PET_SWEATER = $item[astral pet sweater];

boolean canThrowLatte = true;
boolean canGulpLatte = true;

int get_int(string prop) {
	return get_property(prop).to_int();
}

int get_progress() {
	return get_int("wp_progress");
}

void set_progress(int progress) {
	set_property("wp_progress", progress);
}

void chateauRest() {
	int freeRests = total_free_rests() - get_int("timesRested");
	if(freeRests > 0) {		
		visit_url("place.php?whichplace=chateau&action=chateau_restbox");
	}
}

boolean useIfHave(item it) {
	if(item_amount(it) > 0) {
		use(1, it);
		return true;
	}
	return false;
}

void castSkill(skill skillName) {
	if(!have_skill(skillName)) {
		return;
	}
	int cost = mp_cost(skillName);
	if(my_mp() < cost) {
		chateauRest();
	}
	
	use_skill(1, skillName);
}

void chewingGumFish(item itemName) {
	while (item_amount(itemName) < 1) {
		cli_execute("buy chewing gum on a string");
		use(1, $item[chewing gum on a string]);
	}
}

void initializeRun() {
	print("Initializing run");

	set_property("wp_script_day", 0);
	set_property("wp_progress", 0);
	set_property("wp_current_run", get_property("knownAscensions"));
}

void sellPorkElfGems() {
	useIfHave($item[letter from King Ralph XI]);
	useIfHave($item[pork elf goodies sack]);
	foreach stone in $items[hamethyst, baconstone, porquoise] autosell(item_amount(stone), stone);
}

void buffUp(boolean [skill] buffs) {
	foreach buffSkill in buffs {
		if(!have_skill(buffSkill)) {
			print("Can't use buff " + buffSkill + ", you don't have that available.");
			continue;
		}
		string buffName = to_string(buffSkill);
		if(have_effect(to_effect(buffSkill)) == 0) {
			castSkill(buffSkill);
		}
	}
}

boolean canBurnRunaways() {
	
}

void dayOne() {
	print("Starting day 1");

	set_progress(40);

	if (get_progress() == 0) {
		print("Getting free stuff");

		// boxing daydream
		// klaw games

		set_property("kgb_shots", 3);

		pickTeaTree(IT_SOBRIE_TEA); //TODO: This is broken
		getRemainingGeniePocketWishes();

		visit_url("place.php?whichplace=chateau&action=chateau_desk2");
		visit_url("campground.php?action=garden");	

		cli_execute("terminal enquiry stats");
		cli_execute("terminal educate digitize");
		cli_execute("terminal educate extract");

		visit_url("guild.php?place=challenge");
		visit_url("council.php");
	}

	if (get_progress() == 10) {
		print("Getting equipment, equipping it");


		visit_url(urlBuilder("place.php")
			.addParam("whichplace", "town_wrong")
			.addParam("action", "townwrong_precinct")
			.toString());

		visit_url(urlBuilder("place.php")
			.addParam("whichplace", "town_right")
			.addParam("action", "townright_ltt")
			.toString());

		// TODO: other equipment too

	}

	if (get_progress() == 20) {
		print("Taking space jellyfish");

		use_familiar($familiar[space jellyfish]);
		equip($slot[familiar], ITEM_ASTRAL_PET_SWEATER);

		// TODO: use muming trunk to get mp buff I guess
	}

	if (get_progress() == 30) {
		print("Getting toot oriole and meat");

		visitTootOriole();
		sellPorkElfGems();

		//cheatDeck(DECK_CHOICE_1952_CARD);
		autosell(1, $item[1952 Mickey Mantle card]);

		cli_execute("buy toy accordion");
		cli_execute("buy dramatic™");
		use(1, $item[157]);
		chewingGumFish($item[turtle totem]);
		cli_execute("buy detuned radio");

		set_progress(40);
	}

	if (get_progress() == 40) {
		print("Buffing up");

		chateauRest();
		buffUp($skills[springy fusilli, leash of linguini, empathy of the newt, elemental saucesphere, brawnee]);

		set_progress(50);
	}

	// TODO: set up disintegrate here on novelty tropical skeleton
	// TODO: cook oil, ointment, philter

	if (get_progress() == 50) {
		print("Burning banishers and runaways for Source Essence");

		// TODO: NEED TO BE SMARTER ABOUT THIS

		return;

		while(canBurnRunaways() && item_amount($item[source essence]) < 10) {
			if(my_mp() < 5 && (canGulpLatte || canKgbShoot)) {

			} else if (my_mp() < )
		}
	}

	// also take stomping boots or bandersnatch in order to get more free source essence
	// get hacked gibson x 2 (maybe also browser, but could do later), drink with ode

	//candy hearts for free spell damage
	//coil wire


	// spell damage pool table
	//barrel buff
	// kgb to spell damage
	// bastille, equip draftsmans gloves for spell damage
	// spell damage hat from sugar sheet (will consume later for complex candy buff)

	// summon the sugar chapeau
	//spell damage test (what are the buffs here?)

	// gear up to power level now!
	// garbage shirt
	// different hat than sugar chapeau
	// bass clarinet or fish hatchet
	// kol con thing
	// proton for now
	//pantogram
	// kgb
	//draftsman's driving gloves
	// cowboy boots

	//baby sandworm ,astral pet sweater


	//shrug ode

	// buff up
	// get green mana for using giant growth?
	//boxing daycare
	// double elemental damage (bend hell)
	// item buff from sweet (use chapeau here)
	// myst gain buff from sweet
	// myst gain buff from book
	// myst buff from sweet
	// fam weight: empathy, leash, witchess buff
	// defenses: elemental saucesphere, eventually turtle sphere too
	// init: springy fusilli
	// items: fat leon, singer
	// ML: drescher, pride, ur-kel
	// stat buffs: rage, scowl, stevedave's shanty
	// bee's knees (10 drunk)

	// zatanna: myst buff
	// boxing daycare
	// clip art cold filtered water, use it
	// pool table buff (fam weight)
	// ointment, oil of expertise
	// april shower for myst buff
	// falcon liquor
	// spacegate stat buff
	// terminal buffs: stats, damage, items

	// LOV tunnel (epaulettes, stat buff, chocolate and eat it)
	// equip epaulettes, use ten-
	// hit the hot tub for health

	// get greek fire, use it
	// neverending party for stat gain
	// snojo on muscle
	// deep machine tunnels
	// witchess fights (should also d othe item one early, after LOV)
	// eldritch things

	// use steely eyed squint (could use before maybe?)
	// goat
	// milk of mag, time spin 4 browser cookies

	// shattering punch the uncle gator things
	// should hopefully not have too many adventures left here, should see if I can get the browser cookie earlier and get milk of mag guarenteed early (should be doable with quad item drops), then can do both melee and spell damage tests

	// overdrink, + adv gain stuff
}


void main() {
	if(get_int("knownAscensions") != get_int("wp_current_run")) {
		initializeRun();
	}

	dayOne();
}