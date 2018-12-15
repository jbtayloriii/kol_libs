import wp_lib/UrlBuilder.ash;

item DECEASED_CRIMBO_TREE = $item[9691];
item BROKEN_CHAMPAGNE_BOTTLE = $item[9692];
item TINSEL_TIGHTS = $item[9693];
item WAD_OF_USED_TAPE = $item[9694];
item MAKESHIFT_GARBAGE_SHIRT = $item[9699];

int [item] TOTE_ITEM_CHOICES;
TOTE_ITEM_CHOICES[DECEASED_CRIMBO_TREE] = 1;
TOTE_ITEM_CHOICES[BROKEN_CHAMPAGNE_BOTTLE] = 2;
TOTE_ITEM_CHOICES[TINSEL_TIGHTS] = 3;
TOTE_ITEM_CHOICES[WAD_OF_USED_TAPE] = 4;
TOTE_ITEM_CHOICES[MAKESHIFT_GARBAGE_SHIRT] = 5;

string TOTE_URL = urlBuilder("inv_use.php")
	.addParam("which", 3)
	.addParam("whichitem", 9690)
	.addPasswordParam()
	.toString();

void visitGarbageTote() {
	visit_url(TOTE_URL);
}

// todo: implement this
int getGarbageShirtCount() {
	return 0;
}

// todo: implement this
int getGarbageChampagneCount() {
	return 0;
}

// TODO: implement this
int getGarbageDeceasedTreeCount() {
	return 0;
}


// TODO: make this more robust depending on whether you already have the item (and have it equipped)
void selectToteItem(item it) {
	if (!(TOTE_ITEM_CHOICES contains it)) {
		abort("Invalid January Garbage tote item selected");
	}

	visit_url(TOTE_URL);
	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1275)
		.addParam("option", TOTE_ITEM_CHOICES[it])
		.addPasswordParam()
		.toString());
}