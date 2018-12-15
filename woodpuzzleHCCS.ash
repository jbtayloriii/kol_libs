import woodpuzzleAdventure.ash
import woodpuzzleCombat.ash
import woodpuzzleVIP.ash
import UrlBuilder.ash
import BastilleBattalion.ash
import GodLobster.ash
import SongBoomBoomBox.ash
import Snojo2.ash
import BoxingDaycare.ash
import GarbageTote.ash
import GenieBottle.ash
import TunnelOfLov.ash
import EasyVisits.ash
import FortuneTeller.ash
import TeaTree.ash

////////////////////
/* Item Constants */
////////////////////

item KOL_CON_SNOWGLOBE = $item[9133];

boolean debugPrint = true; //verbose printing

//////////////////////
/* helper functions */
//////////////////////

void printd(string str) {
	if(debugPrint) {
		print(str);
	}
}

int get_int(string prop) {
	return get_property(prop).to_int();
}

int get_progress() {
	return get_int("wp_progress");
}

void set_progress(int progress) {
	set_property("wp_progress", progress);
}

void chateau_rest() {
	int freeRests = total_free_rests() - get_int("timesRested");
	if(freeRests > 0) {
		printd("Resting at chateau");
		
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
	printd("Casting skill " + skillName);
	if(!have_skill(skillName)) {
		printd("Cannot cast " + skillName + ", do not have skill");
		return;
	}
	int cost = mp_cost(skillName);
	if(my_mp() < cost) {
		chateau_rest();
	}
	
	use_skill(1, skillName);
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

void equipAccessories(boolean [item] accs) {
	equip($slot[acc1], $item[none]);
	equip($slot[acc2], $item[none]);
	equip($slot[acc3], $item[none]);
	
	foreach it in accs {
		if(item_amount(it) == 0) {
			print("You can't equip accessory " + it + ", you don't have it");
			continue;
		}
		if(!have_equipped(it)) {
			if(!(accs contains equipped_item($slot[acc1]))) {
				equip($slot[acc1], it);
				continue;
			}
			if(!(accs contains equipped_item($slot[acc2]))) {
				equip($slot[acc2], it);
				continue;
			}
			if(!(accs contains equipped_item($slot[acc3]))) {
				equip($slot[acc3], it);
				continue;
			}
		}
	}
}

////////////////////
/* Initialization */
////////////////////

void initializeRun() {
	set_property("wp_script_day", 0);
	set_property("wp_progress", 0);
	set_property("wp_current_run", get_property("knownAscensions"));
}

void drinkBooze(item it, int potency) {
	if(item_amount(it) == 0) {
		abort("Cannot drink " + it + ". You don't have the item.");
	}
	if(inebriety_limit() - my_inebriety() < potency) {
		abort("Can't drink " + it + ". You're going to overdrink.");
	}
	if(have_effect($effect[Ode to Booze]) == 0) {
		castSkill($skill[The Ode to Booze]);
	}
	
	drink(1, it);
}

void eatFood(item it, int fullness, boolean requireMilk) {
	if(item_amount(it) == 0) {
		abort("Cannot eat " + it + ". You don't have the item.");
	}
	if(fullness_limit() - my_fullness() < fullness) {
		abort("Can't eat " + it + ". You're too full.");
	}
	if(item_amount($item[milk of magnesium]) == 0 && requireMilk) {
		abort("Can't eat " + it + ". You don't have required milk of magnesium.");
	}
	
	if(item_amount($item[milk of magnesium]) > 0 && have_effect($effect[Got Milk]) == 0) {
		use(1, $item[milk of magnesium]);
	}
	eat(1, it);
}

boolean switchToFam(familiar fam) {
	if (!have_familiar(fam)) {
		return false;
	}
	
	if (equipped_amount($item[astral pet sweater]) == 1) {
		equip($slot[familiar], $item[none] );
	}
	
	use_familiar(fam);
	if (item_amount($item[astral pet sweater]) == 1) {
		equip($slot[familiar], $item[astral pet sweater] );
	}
	return true;
}

void setupTerminalCombatSkills(string skill1, string skill2) {
	cli_execute("terminal educate " + skill1);
	cli_execute("terminal educate " + skill2);
}

void setupTerminalRollover(string rolloverBuff) {
	cli_execute("terminal enquiry " + rolloverBuff);
}

void sellPorkElfGems() {
	useIfHave($item[letter from King Ralph XI]);
	useIfHave($item[pork elf goodies sack]);
	foreach stone in $items[hamethyst, baconstone, porquoise] autosell(item_amount(stone), stone);
}

void showerMp() {
	if (get_property("_aprilShower") == "false") {
		cli_execute("shower mp");
	} else {
		print("Already used shower", "red");			
	}
}

void terminalItemBuff() {
	visit_url("choice.php?whichchoice=1191&option=1&input=enhance items.enh&pwd=" + my_hash());
}

boolean sweetSynthesis(item candy1, item candy2) {
	if(spleen_limit() - my_spleen_use() < 1) {
		print("Cannot sweet synthesis, no spleen left");
		return false;
	}

	if(item_amount(candy1) == 0) {
		print("Cannot sweet synthesis, have 0 " + candy1);
		return false;
	}
	
	if(item_amount(candy2) == 0) {
		print("Cannot sweet synthesis, have 0 " + candy2);
		return false;
	}

	string candy1Number = candy1.to_int().to_string();
	string candy2Number = candy2.to_int().to_string();
	visit_url("runskillz.php?action=Skillz&whichskill=166&targetplayer=" + my_id() + "&quantity=1");
	visit_url("choice.php?pwd&whichchoice=1217&option=1&a=" + candy1Number + "&b=" + candy2Number + "&pwd=" + my_hash());
	return true;
}

void setupDoghouse() {
	set_property("choiceAdventure1106","2");
}

void timeSpinEat(item it) {
	//todo: validate that this is available
	visit_url("inv_use.php?pwd=&whichitem=9104");
	run_choice(2);
	visit_url("choice.php?pwd=&whichchoice=1197&option=1&foodid=" + it.to_int());
	
}

boolean vip_speakeasy(item drink) {
	if(have_effect($effect[Ode to Booze]) == 0) {
		castSkill($skill[The Ode to Booze]);
	}
	
	int drinkNumber = 0;
	int potency = 0;
	
	if(drink == $item[Sockdollager]) {
		drinkNumber = 6;
		potency = 2;
	}
	//todo: expand to other drinks, make sure to count total number of vip drinks per day
	if(drinkNumber == 0 || (inebriety_limit() - my_inebriety() < potency)) {
	  return false;
	}
	visit_url("clan_viplounge.php?preaction=speakeasydrink&drink=" + drinkNumber + "&pwd=" + my_hash());
	
	return true;
}

void chewingGumFish(item itemName) {
	//todo: add catches to make sure we're fishing for right items
	while (item_amount(itemName) < 1) {
		cli_execute("buy chewing gum on a string");
		use(1, $item[chewing gum on a string]);
	}
}

void witchessBuff() {
	visit_url("campground.php?action=witchess"); //go to witchess
    run_choice(3);
    run_choice(2);
}

//test
void witchessFight(string monsterName, string combatFunc) {
	if(monsterName == "bishop") {
		visit_url("campground.php?action=witchess"); //go to witchess fights
        run_choice(1);
		visit_url("choice.php?whichchoice=1182&option=1&piece=1942&pwd=" + my_hash(), false); //1942 piece: bishop
		if(combatFunc != "") {
			cb_initCombat();
			run_combat(combatFunc);
		} else {
			run_combat();
		}
	}
}

boolean isDigitizeReady() {
	return get_counters("Digitize Monster", 0, 0) != "";
}

void test_coil() {
	if(my_adventures() < 60) {
		abort("Not enough adventures for coil test");
	}
	visit_url("council.php");
	visit_url("choice.php?whichchoice=1089&option=11&pwd="+my_hash());
}

void test_spell_damage() {
	visit_url("council.php");
	visit_url("choice.php?whichchoice=1089&option=7&pwd="+my_hash());
}

void test_melee_damage() {
	visit_url("council.php");
	visit_url("choice.php?whichchoice=1089&option=6&pwd="+my_hash());
}

void test_item() {
	visit_url("council.php");
	visit_url("choice.php?whichchoice=1089&option=9&pwd="+my_hash());
}

void dayOne() {
	if(get_progress() == 0) {
		pickTeaTree(IT_SOBRIE_TEA);
		useBastilleBattalion($stat[mysticality], DRAFTSMAN_DRIVING_GLOVES, $stat[mysticality]);
		getRemainingGeniePocketWishes();
		// vote here, get horse

		visit_url(urlBuilder("place.php")
			.addParam("whichplace", "town_wrong")
			.addParam("action", "townwrong_precinct")
			.toString());

		visit_url(urlBuilder("place.php")
			.addParam("whichplace", "town_right")
			.addParam("action", "townright_ltt")
			.toString());
		
		equip($slot[back], $item[protonic accelerator pack]);
		equip($slot[off-hand], KOL_CON_SNOWGLOBE);

		selectToteItem(MAKESHIFT_GARBAGE_SHIRT);
		equip($slot[shirt], MAKESHIFT_GARBAGE_SHIRT);

		setupDoghouse();
		
		cli_execute("cheat Island");
		vip_cheat_deck(VIP_DECK_AUTOSELL);
		visitTootOriole();
		sellPorkElfGems();
		vip_floundry($item[codpiece]);
		equipAccessories($items[9930, 9493, 9071]);

		//Gulp latte instead
		chateau_rest();
		visit_url("guild.php?place=challenge");
		visit_url("council.php");
		
		set_progress(10);
	}

	if(get_progress() == 10) {	
		setupTerminalRollover("stats");
		setupTerminalCombatSkills("digitize", "extract");
		
		//Chateau juice bar
		visit_url("place.php?whichplace=chateau&action=chateau_desk2");
		visit_url("campground.php?action=garden");	
		
		cli_execute("buy toy accordion");
		cli_execute("buy dramatic™");
		use(1, $item[157]); //dramatic range

		set_progress(12);
	}

	if(get_progress() == 12) {	
		
		chewingGumFish($item[turtle totem]);
		
		switchToFam($familiar[machine elf]);
		
		cli_execute("buy detuned radio");
		change_mcd(10);
		
		if ($item[bitchin' meatcar].available_amount() == 0 && knoll_available()) {
			cli_execute("buy tires");
			cli_execute("buy sweet rims");
			cli_execute("buy spring");
			cli_execute("buy sprocket");
			cli_execute("buy cog");
			cli_execute("buy empty meat tank");
			cli_execute("make meat stack");
			create(1, $item[bitchin' meatcar]);
		}
		
		set_progress(15);
	}
	
	// TODO: Buff up more
	if(get_progress() == 15) {
		unlockSkeletonStore();
		buffUp($skills[springy fusilli, sauce contemplation]);
		
		//add in digitize
		witchessFight("bishop", "combatDigitize");
		set_progress(20);
	}

	if(get_progress() == 20) {
		
		//get bag of many thing
		use_familiar($familiar[stocking mimic]);
		witchessFight("bishop", "combatNormal");
		equip($slot[familiar], $item[none] );
		
		switchToFam($familiar[machine elf]);
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		drinkBooze($item[sacramento wine], 1);
		drinkBooze($item[sacramento wine], 1);
		drinkBooze($item[sacramento wine], 1);
		drinkBooze($item[sacramento wine], 1);
		drinkBooze($item[sacramento wine], 1);
	
		set_progress(24);
	}
	
	if(get_progress() == 24) {
		test_coil();
		set_progress(27);
	}

	//TODO: NEVERENDING PARTY HERE

	if(get_progress() == 27) {
		fightGodLobster("combatNormal", GOD_LOBSTER_BUFF);
		fightGodLobster("combatNormal", GOD_LOBSTER_EQUIPMENT);
		equipGodLobster($item[god lobster's scepter]);
		fightGodLobster("combatNormal", GOD_LOBSTER_BUFF);
		set_progress(30);
	}
	
	if(get_progress() == 30) {
		castSkill($skill[perfect freeze]);
		castSkill($skill[summon crimbo candy]);
		castSkill($skill[Advanced Saucecrafting]);
		castSkill($skill[Advanced Cocktailcrafting]);
		castSkill($skill[Summon Alice's Army Cards]);
		castSkill($skill[Pastamastery]);
		
		//get item buff from candy
		use(1, $item[peppermint sprout]);
		sweetSynthesis($item[peppermint sprout], $item[peppermint twist]);
		
		//get learning buff from candy
		if(item_amount($item[crimbo peppermint bark]) > 0) {
			sweetSynthesis($item[peppermint sprout], $item[crimbo peppermint bark]);			
		} else if(item_amount($item[crimbo fudge]) > 1) {
			sweetSynthesis($item[crimbo fudge], $item[crimbo fudge]);
		} else if(item_amount($item[crimbo fudge]) > 0 && item_amount($item[bag of many confections]) > 0) {
			sweetSynthesis($item[crimbo fudge], $item[bag of many confections]);		
		} else {
			abort("got bad crimbo candy, should fix this");
		}
		
		if(isDigitizeReady()) {
			//still not fully working
			adv1($location[The Haunted Pantry] , 1, "combatNormal");
		}
		
		enterTunnelOfLov(LOV_EQUIPMENT_EPAULETTES, LOV_BUFF_ITEM_DROPS, LOV_ITEM_CHOCOLATE, "combatNormal");

		visit_url("clan_viplounge.php?action=hottub");
		equip($slot[back], $item[LOV Epaulettes]);

		set_progress(35);
	}

	if(get_progress() == 35) {
		use(1, $item[LOV Extraterrestrial Chocolate]);
		
		visit_url("clan_viplounge.php?preaction=poolgame&stance=3"); //play stylishly
		witchessBuff();
		
		cli_execute("cheat The wheel of fortune");
		cli_execute("terminal enhance items");
		
		//skill buffs for fighting, items, etc.
		buffUp($skills[springy fusilli, empathy of the newt, leash of linguini, fat leon's phat loot lyric]);
		
		//take space jellyfish, evoke horror, get and use jelly maybe
		
		set_progress(40);
	}
	
	if(get_progress() == 40) {
		switchToFam($familiar[machine elf]);
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		
		set_property("choiceAdventure1119","1");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		
		if(item_amount($item[abstraction: category]) > 0) {
			chew(1, $item[abstraction: category]);
		}
		use(1, $item[a ten-percent bonus]);	
		set_progress(50);
	}
	
	if(get_progress() == 50) {
		switchToFam($familiar[Pair of Stomping Boots]);
		visit_url("place.php?whichplace=chateau&action=chateau_painting");
		run_combat("combatChateau");
		if(item_amount($item[glass of goat's milk]) > 0) {
			craft("cook", 1, $item[glass of goat's milk], $item[Scrumptious reagent]);
		}
		
		set_progress(60);
	}
	
	if(get_progress() == 60) {
		cli_execute("terminal extrude food");
		
		//todo: check for mayo clinic, make sure that browser cookie was gotten
		cli_execute("buy mayodiol");
		if(!useIfHave($item[mayodiol])) {
			abort("trouble with mayodiol");
		}
		eatFood($item[browser cookie], 4, false); //6 drunk, 3 fullness
		timeSpinEat($item[browser cookie]);
		timeSpinEat($item[browser cookie]);
		timeSpinEat($item[browser cookie]);
		
		//fullness 15, drunkness 6
		
		set_progress(70);
	}
	
	if(get_progress() == 70) {
		switchToFam($familiar[machine elf]);
		int snojoFights = 5;
		
		//muscle mode
		set_property("choiceAdventure1118","1");
		visit_url("place.php?whichplace=snojo&action=snojo_controller");
		visit_url("choice.php?pwd=" + my_hash() + "&whichchoice=1118&option=1");
		buffUp($skills[springy fusilli, leash of linguini, empathy of the newt]);
		
		//Only doing 5 fights right now
		//TODO: SNOJO
		while(snojoFights > 0) {
			adv1($location[The X-32-F Combat Training Snowman], 1, "combatNormal");
			if(my_hp() < 100 || my_mp() < 40) {
				chateau_rest();				
			}
			snojoFights -= 1;
		}
		
		set_progress(80);
	}
	
	if(get_progress() == 80) {
		switchToFam($familiar[Pair of Stomping Boots]);
		
		//intro adventure
		adv1($location[The skeleton store], 1, "combatNormal");
		
		buffUp($skills[Musk of the Moose, Carlweather's Cantata of Confrontation]);
		equipAccessories($items[your cowboy boots, 9493, 9071]);
		while(item_amount($item[lemon]) < 1) {
			adv1($location[The skeleton store], 1, "combatSkeletonStore");	
		}
		craft("cook", 1, $item[Scrumptious reagent], $item[lemon]);
		craft("cook", 1, $item[Scrumptious reagent], $item[cherry]);
		craft("cook", 1, $item[Scrumptious reagent], $item[grapefruit]);
		
		//Haiku dungeon
		buffUp($skills[Musk of the Moose, Carlweather's Cantata of Confrontation]);
		set_property("choiceAdventure297","3");
		
		while(item_amount($item[li'l ninja costume]) < 1) {
			adv1($location[The Haiku Dungeon], 1, "combatHaikuDungeon");	
		}		
		set_progress(90);
	}

	return;
	
	if(get_progress() == 90) {
		if (item_amount($item[protonic accelerator pack]) > 0) {
			equip($slot[back], $item[protonic accelerator pack]);
		}
		buffUp($skills[fat leon's phat loot lyric, Singer's Faithful Ocelot, steely-eyed squint]);
		//useIfHave($item[abstraction: certainty]);
		useIfHave($item[cyclops eyedrops]);

		//todo: kgb, genie


		use_familiar($familiar[Trick-or-Treating Tot]);
		equip($slot[familiar], $item[li'l ninja costume] );

		getFortuneTellerBuff(FORTUNE_ITEM_BUFF);
	
		test_item();
		set_progress(100);
	}

	if(get_progress() == 100) {
		cli_execute("terminal extrude booze");
		cli_execute("terminal extrude booze");
		if(item_amount($item[hacked gibson]) < 2) {
			abort("Not enough source essence for hacked gibson");
		}

		drinkBooze($item[hacked gibson], 4);
		drinkBooze($item[hacked gibson], 4);

		set_progress(110);
	}

	if(get_progress() == 110) {

		//pool table
		//todo: deep dark visions
		buffUp($skills[Arched Eyebrow of the Archmage, Song of Sauce, simmer, Jackasses' Symphony of Destruction]);

		visit_url("clan_viplounge.php?preaction=poolgame&stance=2"); //play smartly

		useIfHave($item[Corrupted marrow]);
		useIfHave($item[LOV Elixir #6]);
		useIfHave($item[Tobiko marble soda]);

		test_spell_damage();
		set_progress(120);
	}

	if(get_progress() == 120) {
		//pool table
		buffUp($skills[Jackasses' Symphony of Destruction, bow-legged swagger, Blessing of the War Snapper, Tenacity of the snapper, rage of the reindeer, scowl of the auk, song of the north]);
		useIfHave($item[Corrupted marrow]);
		useIfHave($item[LOV Elixir #3]);
		useIfHave($item[wasabi marble soda]);
		visit_url("clan_viplounge.php?preaction=poolgame&stance=1"); //play aggressively

		//genie outer wolf?

		test_melee_damage();
		set_progress(130);
	}

	if(get_progress() == 130) {
		//todo: kgb rollover
		buy(1, $item[Li'l unicorn costume]);
		equip($slot[familiar], $item[Li'l unicorn costume] );

		castSkill($skill[The Ode to Booze]);
		castSkill($skill[The Ode to Booze]);
		drink(1, $item[emergency margarita]);
	}
	
	//other: yellow ray for hot resist stuff
	//think about bubblin' caldera somewhere in here
	//any extra cheats here?
	//genie
}

void dayTwo() {

	if(get_progress() == 200) {
		cli_execute("cheat Island");
		cli_execute("cheat Ancestral Recall");
		cli_execute("cheat Gift Card");

		pickTeaTree(IT_SOBRIE_TEA);
		getRemainingGeniePocketWishes();

		castSkill($skill[perfect freeze]);
		castSkill($skill[Advanced Saucecrafting]);
		castSkill($skill[Advanced Cocktailcrafting]);
		castSkill($skill[Summon Alice's Army Cards]);
		castSkill($skill[Pastamastery]);
		visit_url("campground.php?action=garden");
		visit_url("campground.php?action=workshed");
		visit_url("place.php?whichplace=chateau&action=chateau_desk2");
		vip_floundry($item[Fish Hatchet]);

		changeSongBoomSong(REMAINING_ALIVE);
		set_progress(203);
	}

	if(get_progress() == 203) {
		selectToteItem(MAKESHIFT_GARBAGE_SHIRT);
		equip($slot[shirt], MAKESHIFT_GARBAGE_SHIRT);

		useBastilleBattalion($stat[mysticality], DRAFTSMAN_DRIVING_GLOVES, $stat[mysticality]);

		useIfHave($item[ointment of the occult]);
		equip($item[fish hatchet]);

		enterTunnelOfLov(LOV_EQUIPMENT_EPAULETTES, LOV_BUFF_FAMILIAR_WEIGHT, LOV_ITEM_CHOCOLATE, "combatNormal");
		equip($slot[back], $item[LOV Epaulettes]);



		boxingDaydream();
		boxingDaySpa(0); // TODO: Change day spa enum value


		fightGodLobster("combatNormal", GOD_LOBSTER_EQUIPMENT);
		equipGodLobster($item[god lobster's ring]);
		set_progress(205);
	}

	if(get_progress() == 205) {

		changeSnojoStat($stat[mysticality]);
		adv1($location[The X-32-F Combat Training Snowman], 1, "combatNormal");
		adv1($location[The X-32-F Combat Training Snowman], 1, "combatNormal");
		adv1($location[The X-32-F Combat Training Snowman], 1, "combatNormal");
		adv1($location[The X-32-F Combat Training Snowman], 1, "combatNormal");
		adv1($location[The X-32-F Combat Training Snowman], 1, "combatNormal");

		set_progress(207);
	}

	if(get_progress() == 207) {
		switchToFam($familiar[machine elf]);
		buffUp($skills[springy fusilli, empathy of the newt, leash of linguini, fat leon's phat loot lyric]);
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		adv1($location[The Deep Machine Tunnels], 1, "combatNormal");
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		witchessFight("bishop", "combatNormal");
		set_progress(210);
	}
	
	if(get_progress() == 210) {
		cli_execute("terminal extrude food");
		eatFood($item[browser cookie], 4, false);
		timeSpinEat($item[browser cookie]);
		timeSpinEat($item[browser cookie]);
		
		//should time spin tea and eat tea
	
		set_progress(220);
	}
	
	if(get_progress() == 220) {
		if(item_amount($item[astral six-pack]) > 0) {
			use(1, $item[astral six-pack]);	
		}
		
		if(item_amount($item[astral pilsner]) == 6) {
			drinkBooze($item[astral pilsner], 1);
			drinkBooze($item[astral pilsner], 1);
			drinkBooze($item[astral pilsner], 1);
			drinkBooze($item[astral pilsner], 1);
			drinkBooze($item[astral pilsner], 1);
			drinkBooze($item[astral pilsner], 1);
		} else {
			abort("Problem drinking astral booze.");
		}
		
		
		set_progress(230);
	}
	
	if(get_progress() == 230) {
		cli_execute("terminal extrude booze");
		cli_execute("terminal extrude booze");
		drinkBooze($item[hacked gibson], 4);
		drinkBooze($item[hacked gibson], 4);
	
		set_progress(240);
	}
	
	if(get_progress() == 230) {
		if( have_effect($effect[Phorcefullness]) == 0) {
			use(1, $item[philter of phorce]);
		}
		if(have_effect($effect[expert oiliness]) == 0) {
			use(1, $item[oil of expertise]);
		}
		
		//candy buff for hp x 2
		
		// Ben-gal balm
		buy(1, $item[2595]);
		use(1, $item[2595]);
		
		if(have_effect($effect[action]) == 0 && item_amount($item[abstraction: action]) > 0) {
			chew(1, $item[abstraction: action]);
		}
		
		if(have_effect($effect[ancient fortitude]) == 0 && item_amount($item[ancient medicinal herbs]) > 0) {
			chew(1, $item[ancient medicinal herbs]);
		}
		
		//space gate if have
		//daily affirmation if 
		
		//do hp test
	
		//set_progress(240);
	}
	
	if(get_progress() == 240) {	
		set_progress(250);
	}
	
	if(get_progress() == 250) {
		//philter
		//abstraction
		//candy buff
		//oil
		//ben-gal
		//220: muscle test
	
		set_progress(260);
	}
	
	//myst test
	
	//moxie test
	
	//buff fam weight
	//lov tunnel
	//witchess buff
	//pool table
	//familiar test
	
	//buff noncombat
	//noncombat items
	//2 skills
	//vip swimming
	//proton pack
	//kgb?
	
	//hot test
	//trick or treating tot
	//cast 2 shells
	//candy
	//pocket maze i guess
	//yellow ray if have
	//kgb?
	//ox shield ?
	
	
}

void main() {
	if(get_int("knownAscensions") != get_int("wp_current_run")) {
		initializeRun();
	}
	
	if(my_daycount() == 1) {
		dayOne();
	} else {
		dayTwo();
	}
}
