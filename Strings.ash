
string join(string one, string two, string delim) {
	if(one.length() == 0) {
		return two;
	}
	if(two.length() == 0) {
		return one;
	}
	return one + delim + two;
}