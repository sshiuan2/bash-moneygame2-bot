_bot_get_login_reward(){
	local jqPath=$(getJqPath);
	local api;
	local res;

	api=get_login_bonus;
	res=$(callStandardApi $api);
	#todo check ok or not and log
}

_bot_get_achievement_reward(){
	local api=achieve_set;
	local achievement_type=$1;
	local key=$2;
	callStandardApi $api $key $achievement_type;
	return $?;
}
