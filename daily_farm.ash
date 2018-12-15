

boolean [item] TEA_ITEMS = $items[8624, 8626, 8603, 8611, 8636, 8625, 8617, 8613, 8601, 8618, 8606, 8631, 8619, 8605, 8637, 8621, 8623, 8628, 8622, 8629, 8610, 8604, 8608, 8616, 8620, 8614, 8609, 8635, 8612, 8634, 8607, 8630, 8627, 8633, 8615, 8602];


void tea_tree() {
	int best_price = 0;
	item best_item = $item[none];
	foreach it in TEA_ITEMS {
		int price = mall_price(it);
		if (price > best_price) {
			best_price = price;
			best_item = it;
		}
	}
	print("best tea tree price: " + best_price);
	print("best tea tree item: " + best_item);

	visit_url("choice.php?whichchoice=1105&option=1&itemid=" + best_item.to_int() + "&pwd=" + my_hash());

	put_shop(best_price - 1, 0, best_item);
}

void precinct_headquarters() {
	visit_url("place.php?whichplace=town_wrong&action=townwrong_precinct");
	
	buffer page = visit_url("choice.php?whichchoice=1193&option=1&pwd=" + my_hash());
	//visit_url("wham.php");
	visit_url("wham.php?visit=3");
	visit_url("wham.php?accuse=3");

	print(page);
}

void main() {
	#tea_tree();
	precinct_headquarters();
}
