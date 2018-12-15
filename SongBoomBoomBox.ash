import UrlBuilder.ash;

int EYE_OF_THE_GIGER = 1;
int FOOD_VIBRATIONS = 2;
int REMAINING_ALIVE = 3;
int THESE_FISTS = 4;
int TOTAL_MEAT_ECLIPSE = 5;

// TODO: Implement this
int getCurrentSongBoomSong() {
	return 0;
}

void changeSongBoomSong(int newChoice) {
	if(newChoice < 1 || newChoice > 5) {
		abort("Invalid SongBoom choice");
	}

	visit_url(urlBuilder("inv_use.php")
		.addParam("whichitem", 9919)
		.addParam("which", 3)
		.addPasswordParam()
		.toString());

	visit_url(urlBuilder("choice.php")
		.addParam("whichchoice", 1312)
		.addParam("option", newChoice)
		.addPasswordParam()
		.toString());
}