
_bot_mail_invest_handle(){
	local jqPath=$(getJqPath);
	local api;
	local res;
	local bonds;
	local bond_d;
	local pattern;

	local page=1;
	api=get_invest_mail;
	res=$(callStandardApi $api $page);
	pattern='.list[]|if .state == "n" then .d else empty end';
	bonds=$(echo $res|$jqPath "$pattern");

	api=investment_mail_check;
	for bond_d in ${bonds[@]};do
		bond_d=${bond_d:1:-1};
		echo "buy bond: $bond_d";
		res=$(callStandardApi "$api" "$bond_d");
		echo $res;
	done
}

_bot_mail_handle(){
	local api;
	local res;

	echo "start mail handle...";

	api=get_mail_getAttachment_all
	res=$(callStandardApi $api normal);
	echo $res;
	res=$(callStandardApi $api trade);
	echo $res;
	res=$(callStandardApi $api interest);
	echo $res;

	_bot_mail_invest_handle;

	echo "end mail handle...";
}