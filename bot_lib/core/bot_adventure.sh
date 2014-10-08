
_bot_adventure_check_boss_exist_and_get_id(){
	local jqPath=$(getJqPath);
	local api=adventure_boss;
	local res;
	local area=$1;
	local level=$2;

	res=$(callStandardApi $api $area $level);
	err_msg=$(echo $res|$jqPath ".msg");
	err_msg=${err_msg:1:-1};

	if [ "$err_msg" == "y" ];then
		boss_id=$(echo $res|$jqPath ".value_ex.id");
		echo $boss_id;
		return 0;
	else
		echo $err_msg;
		return 2;
	fi
}

_bot_adventure_complete_map_handle(){
	local map=$1;
	local adventure_mode=$2;
	local detect_method=$3;

	local areas;
	local area;

	case $map in
		1)
		#
		areas=(1 2 3 4 5 6 7 8 9 10 11 12 13);
		;;
		*)
		#
		areas=(1 2 3 4 5 6 7 8 9 10 11 12 13);
		;;
	esac

	for area in "${areas[@]}"; do
		_bot_adventure_complete_area_handle $area $adventure_mode $detect_method;
		err=$?;
		if [ "$err" != "0" ];then
			return $err;
		fi
	done
}
_bot_adventure_complete_area_handle(){
	local area=$1
	local adventure_mode=$2;
	local detect_method=$3;

	local i;
	for ((i=1;i<=5;i++)); do
		_bot_adventure_complete_level_handle $area $i $adventure_mode $detect_method;
		err=$?;
		if [ "$err" != "0" ];then
			return $err;
		fi
	done
}
_bot_adventure_complete_level_handle(){
	local jqPath=$(getJqPath);
	local api=adventure_run;
	local res;
	local err;
	local err_msg;

	local area=$1;
	local level=$2;
	local adventure_mode;
	if [ -z "$3" ];then
		adventure_mode=${__g[adventure_mode]};
	else
		adventure_mode=$3;
	fi
	local detect_method=$4;

	local key;
	local boss_id;

	#@return	0 is completed
	#			2 error

	res=$(_bot_adventure_check_boss_exist_and_get_id $area $level);
	err=$?;
	if [ "$err" == "0" ];then
		boss_id=$res;
	else
		echo $res;
		case $res in
			no_tp )
			#
			return 2;
			;;
			'非當前BOSS')
			#
			return 0;
			;;
			* )
			#
			return $err;
			;;
		esac
	fi

	case $detect_method in
		'key')
		#
		api=adventure_run;
		while true ;do
			res=$(callStandardApi $api $area $level $adventure_mode);
			_bot_adventure_response_handle $res;
			# {key: "boss"}
			key=$(echo $res|$jqPath '.key');
			if [ "$key" == "boss" ];then
				boss_id=$(echo $res|$jqPath '.value_ex.id');
				break;
			fi
		done
		;;
		'lv')
		#
		local lv=$5;
		api=adventure_run;
		while true ;do
			res=$(callStandardApi $api $area $level $adventure_mode);
			_bot_adventure_response_handle $res;
			# {lv: 3}
			key=$(echo $res|$jqPath '.lv');
			if [ "$key" == "$lv" ];then
				break;
			fi
		done
		;;
		*)
		#
		while true ;do
			api=adventure_run;
			res=$(callStandardApi $api $area $level $adventure_mode);
			# {per: 100}
			key=$(echo $res|$jqPath ".per");

			if [ "$key" == "null" ];then
				echo $res
				return 2;
			fi

			echo $area - $level - "$key"%;

			if [ "$key" == "100" ];then
				api=adventure_boss;
				res=$(callStandardApi $api $area $level);
				err_msg=$(echo $res|$jqPath ".msg");
				err_msg=${err_msg:1:-1};
				if [ "$err_msg" == "y" ];then
					boss_id=$(echo $res|$jqPath ".value_ex.id");
					echo "boss: $boss_id";
					break;
				else
					echo $err_msg;
					return 2;
				fi
			fi
		done
		;;
	esac

	#todo check bag to sell items;

	if [ -z "$boss_id" ];then
		return 0;
	else
		_bot_vs_monster $boss_id;
		return $?;
	fi

}

_bot_adventure_event_handle(){
	local jqPath=$(getJqPath);
	local sub_event=$1;

	case $sub_event in
		"SuperMonster")
		#
		echo "$sub_event";
		((__g[total_monster]++));
		((__g[total_elite_monster]++));
		;;
		"monster")
		#
		echo "$sub_event";
		((__g[total_monster]++));
		;;
		"boss")
		#
		echo "$sub_event";
		((__g[total_monster]++));
		((__g[total_boss]++));
		;;
		"money")
		#
		local money=$(echo $response|$jqPath .value);
		# money=${money:1:-1};
		echo get money: $money;

		__g[total_adventure_money]=$((${__g[total_adventure_money]}+$money));
		__g[total_money]=$((${__g[total_money]}+$money));
		;;
		"bonus")
		#
		local item=$(echo $response|$jqPath .value);
		item=`echo $item|grep -o '\([^"]*\)'`;

		local item_id=${item%%:*};
		local count=${item##*:};

		#count item
		if [[ -z "${__g[$item_id]}" ]];then
			__g[$item_id]=$count;
		else
			__g[$item_id]=$((${__g[$item_id]}+$count));
		fi
		__g[total_items]=$((${__g[total_items]}+$count));
		echo get item: $item_id x $count;
		echo '=>' sum: ${__g[$item_id]} / total: ${__g[total_items]};

		_bot_item_handle ${__g[item_handle]} $item_id $count;
		;;
		"nothing")
		#
		echo "$sub_event";
		;;
		"no_space")
		#
		echo "bag has no space...";
		exit 2;
		;;
		*)
		#
		echo "unknow sub event";
		exit 2;
		;;
	esac
}

_bot_adventure_response_handle(){
	local jqPath=$(getJqPath);
	local response=$1;

	#use jq to parse json.
	local checker=$(echo $response|$jqPath -e '.msg' 2>/dev/null);
	local err=$?;

	if [ "$err" == "0" ];then
		checker=${checker:1:-1};
	else
		echo "can't parse by jq:"
		echo "$response";
		return $err;
	fi

	#add all fail times 1
	((__g[total_callApi_fail_times]++));
	case $checker in
		"no_tp")
		#
		echo $checker;

		_bot_mail_handle;
		getReport;

		sleep $(getDelay idle);

		reload_config_all;
		case ${__g[no_tp_handle_method]} in
			"auto_buy")
			#
			local item_id=790103;
			local amount=1;
			_bot_buy $item_id $amount;
			;;
			"nothing")
			#
			;;
		esac

		;;
		"y")
		#
		((__g[total_callApi_fail_times]--));
		((__g[total_callApi_success_times]++));
		((__g[total_adventure_times]++));

		local exp=$(echo $response|$jqPath .exp);
		__g[total_exp]=$((${__g[total_exp]}+$exp));

		local exp_total=$(echo $response|$jqPath .exp_now);

		echo "exp: $exp / $exp_total";

		local sub_event=$(echo $response|$jqPath .key);
		sub_event=${sub_event:1:-1};

		_bot_adventure_event_handle $sub_event;
		;;
		*)
		#
		echo "unknown error msg";
		echo checker: $checker;
		exit 2;
		;;
	esac
}

_bot_run_adventure(){
	local response;
	response=$(callEvent adventure_run);
	_bot_adventure_response_handle $response;
}