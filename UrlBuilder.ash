import Strings.ash;

string URL_PLACE = "place.php";
string URL_CHOICE = "choice.php";

string PARAM_WHICHPLACE = "whichplace";

record UrlBuilder {
	string base;
	string [string] params;
};

UrlBuilder urlBuilder(string url) {
	UrlBuilder builder;
	builder.base = url;
	return builder;	
}

// TODO: Phase this one out
UrlBuilder newBuilder(string url) {
	UrlBuilder builder;
	builder.base = url;
	return builder;
}

UrlBuilder addParam(UrlBuilder builder, string key, string value) {
	builder.params[key] = value;
	return builder;
}

UrlBuilder addPasswordParam(UrlBuilder builder) {
	return builder.addParam("pwd", my_hash());
}

string build(UrlBuilder builder) {
	if (count(builder.params) == 0) {
		return builder.base;
	}

	string params = "";
	foreach key in builder.params {
		string value = builder.params[key];
		params = params.join(key + "=" + value, "&");
	}
	return builder.base + "?" + params;	
}

//TODO: Delete usage of this
string toString(UrlBuilder builder) {
	return build(builder);
}