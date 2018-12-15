import wp_lib/UrlBuilder.ash;

/*******************************
 * MAY 2018 - GOD LOBSTER
 *******************************/

int GOD_LOBSTER_EQUIPMENT = 1;
int GOD_LOBSTER_BUFF = 2;
int GOD_LOBSTER_STATS = 3;

string GOD_LOBSTER_URL = urlBuilder("main.php")
	.addParam("fightgodlobster", 1)
	.toString();

string GOD_LOBSTER_OUT_OF_FIGHTS = "You can't challenge your God Lobster anymore";
string BEATEN_UP = "You lose. You slink away, dejected and defeated";

/** 
 * Fights your god lobster and accepts the given gift from it.
 *
 * @return Returns true if you win the fight and false if you lose the fight.
 * @abort If you don't have the god lobster, you pass invalid params, or you're out of god lobster fights
 */
boolean fightGodLobster(String combatScript, int option) {
	print("Fighting God Lobster");
	
	if(!have_familiar($familiar[god lobster])) {
		abort("No god lobster");
	}
	if(option < 1 || option > 3) {
		abort("invalid god lobster option");
	}

	familiar prevFamiliar = my_familiar();

	if(my_familiar() != $familiar[god lobster]) {
		use_familiar($familiar[god lobster]);		
	}

	if(visit_url(GOD_LOBSTER_URL).index_of(GOD_LOBSTER_OUT_OF_FIGHTS) > -1) {
		abort("Out of god lobster fights");
	}
	buffer page = run_combat(combatScript);

	if(page.index_of(BEATEN_UP) > -1) {
		return false;
	}

	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1310)
		.addPasswordParam()
		.addParam("option", option)
		.toString());

	use_familiar(prevFamiliar);
	return true;
}

void equipGodLobster(item equipment) {
	familiar prevFamiliar = my_familiar();

	if(my_familiar() != $familiar[god lobster]) {
		use_familiar($familiar[god lobster]);		
	}
	equip($slot[familiar], equipment);

	use_familiar(prevFamiliar);
	
}