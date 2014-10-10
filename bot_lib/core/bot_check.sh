_bot_check_and_up_lv(){
	local jqPath=$(getJqPath);
	local api=adventure_run;
	local res;
	local err;

	local lv=$1;

	t_role=$(_bot_get_role_data t_role);
	lv_now=$(echo $t_role|$jqPath ".lv");
	lv_now=${lv_now:1:-1};
	if (( $lv_now < $lv )); then
		echo "lv now is $lv_now < $lv, so run adventure";
		while true; do
			res=$(callEvent $api);
			lv_now=$(echo $res|$jqPath ".lv");
			echo "recieved now lv: $lv_now";
			if (( $lv_now >= $lv ));then
				break;
			fi
		done;
	fi
	echo "Current lv is $lv_now";
	return 0;

}

_bot_check_achievements_and_get_reward(){
	local method;
	if [ "$1" == "" ];then
		method=all;
	else
		method=$1;
	fi
	local ids;
	local types=(
		continuepkwin
		pkwin
		);
	#check role_data t_achieve
	case $method in
		all)
		#
		;;
		newbie)
		#
		ids==(
			01
			1
			11
			11
			);
		_bot_get_achievement_reward lv 01;
		_bot_get_achievement_reward lv 1;
		_bot_get_achievement_reward continuepkwin 11;
		_bot_get_achievement_reward pkwin 11;
		;;
	esac
}