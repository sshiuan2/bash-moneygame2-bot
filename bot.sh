#!/bin/bash

###############
# import libs #
###############

. lib/class_text.sh;
. lib/class_parser.sh;
. lib/class_loader.sh;
. lib/class_game_api.sh;
#TODO check jq exist.

##############
# load class #
##############

class_text;

#help info
case $1 in
	"")
	#
	text_short_help `basename $0`;
	exit 0;
	;;
	"--help")
	#
	text_help `basename $0`;
	exit 0;
	;;
esac

class_parser;
class_loader;
class_game_api;

###########################
# global config variables #
###########################

declare -A __g;
__g[bot_name]=$1;
shift;
__g[bot_config_path]="bot/${__g[bot_name]}";

reload_counter_config;
reload_config_all;

#check if it's not filename, and set the id to __g[id]
if [ "${#__g[bot_name]}" == "32" ];then
	__g[id]=${__g[bot_name]};
fi

###########################
# load bot packed methods #
###########################

. bot_lib/bot.sh;

_bot_daily_handle(){
	_bot_get_login_reward;
	_bot_vs_player;
}

__bot__(){
	local loop=$1;
	local delay;
	local delay_sum=0;
	local delay_limit=$((8*60*60));

	echo "init report test: ";
	getReport;

	case $loop in
		"")
		#
		_bot_daily_handle;
		while true;do
			_bot_run_adventure;

			delay=$(getDelay query);
			sleep $delay;
			delay_sum=$(($delay_sum+$delay));

			if (($delay_sum > $delay_limit));then
				_bot_daily_handle;
				delay_sum=0;
			fi
		done;
		;;
		*)
		#
		_bot_daily_handle;
		for [1..$loop..1]; do
			_bot_run_adventure;

			delay=$(getDelay query);
			sleep $delay;
			delay_sum=$(($delay_sum+$delay));

			if (($delay_sum > $delay_limit));then
				_bot_daily_handle;
				delay_sum=0;
			fi
		done
		;;
	esac
}

_bot_newbie_grow_up(){
	_bot_run_newbie_missions $@;
	_bot_clear_newbie_notices;

	#_bot_login_touch_files;

	#maybe is the real register parsing service?
	# https://moneyage2.imoncloud.com:37465/sockjs/info
	# {"websocket":true,"origins":["*:*"],"cookie_needed":false,"entropy":895078671}
	# wss://moneyage2.imoncloud.com:37465/sockjs/363/7o0qt5xc/websocket
	#curl "wss://moneyage2.imoncloud.com:37465/sockjs/363/7o0qt5xc/websocket" -H "Pragma: no-cache" -H "Origin: https://funto.azurewebsites.net" -H "Sec-WebSocket-Key: b6McflNdYZOc/G8bD5sWJw==" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36" -H "Upgrade: websocket" -H "Sec-WebSocket-Extensions: permessage-deflate; client_max_window_bits, x-webkit-deflate-frame" -H "Cache-Control: no-cache" -H "Cookie: ic.sess=699182B0-D864-425A-AFEF-F38D22C974C1" -H "Connection: Upgrade" -H "Sec-WebSocket-Version: 13" --compressed

	#try run all level.
	local adventure_mode=search;
	_bot_adventure_complete_map_handle 1 $adventure_mode;

	api=add_potential;
	#add p_840009 first to save tp
	callStandardApi $api p_840009 search;

	#買vip4
	_bot_buy 790604 1;

	#check lv 10 to solve guild mission
	_bot_check_and_up_lv 10;
	err=$?;
	if [ "$err" == "0" ];then
		echo 'now lv >= 10, run the guild mission.';
	else
		echo "can not lv to 10 skip following steps from newbie guild mission";
		return $err;
	fi

	callStandardApi group_info_join 55; #飯包大大公會id
	_bot_run_newbie_guild_mission;

	_bot_daily_handle;
	_bot_mail_handle $@;

	_bot_run_newbie_main_missions;

	_bot_check_achievements_and_get_reward newbie;

	#take potions.
	_bot_eat 710601;
	_bot_eat 710601;
	_bot_eat 710301;
	_bot_eat 710301;

	#todo mount the (need get armor id first)
	# api=equip_input;
	# item_d=;
	# res=$(callStandardApi $api $item_d w);
	# echo $res;

	#+200maxtp
	#attr=shop_used&d=795161&dd=all&id=
	#attr=shop_used&d=795161&dd=all&id=

	#extent bag (rewards)
	#attr=shop_used_count&d=795403&count=1&id=
	#attr=shop_used_count&d=795403&count=1&id=

	local jqPath=$(getJqPath);
	local user_id=$(_bot_get_role_data t_role id);
	echo "the user_id: $user_id";

	callStandardApi group_role_leave $user_id;
}

############
# commands #
############

#set default cmd arg
if [ "$1" == "" ];then
	event=__bot__;
else
	event=$1;
	shift;
fi;

case $event in
	"__bot__")
	#
	$event $@;
	;;
	"__id")
	#
	__g[id]=$1;
	shift;
	_bot_get_role_data $@;
	;;
	"quick")
	#
	__g[no_tp_handle_method]=stop;
	__g[random_interval]=0;
	__g[query_interval]=0;
	__g[idle_interval]=5;
	__bot__ $@;
	;;
	"grow_up")
	#new bot to lv 10!
	_bot_newbie_grow_up $@;
	;;
	"register")
	# acc pw
	_bot_register $@;
	;;
	"newbie")
	# acc pw
	_bot_run_newbie_missions $@;
	_bot_clear_newbie_notices;
	;;
	"newbie_guild")
	#
	echo "remember join comp first!!!!!";
	_bot_run_newbie_guild_mission;
	;;
	"newbie_main")
	# acc pw
	_bot_run_newbie_main_missions $@;
	;;
	"me")
	#
	_bot_get_role_data $@;
	;;
	"get")
	#
	_bot_get_other_role_data $@;
	;;
	"market")
	#
	_bot_get_market_info $@;
	;;
	"bag")
	#show bag content
	_bot_get_bag_data $@;
	;;
	"buy")
	#gold buy
	# 790604 1 vip4
	# 790103 1 (12000+)
	# 790113 1 (1500+max)
	_bot_buy $@;
	;;
	"trade")
	#market trade
	#buy/sell/auto_sell $item_id $price $amount
	_bot_trade $@;
	;;
	"drop")
	#drop item
	#$item_id $amount
	_bot_drop_item $@;
	;;
	"eat")
	#
	_bot_eat $@;
	;;
	"make")
	#
	_bot_make $@;
	;;
	"rename")
	#
	_bot_rename $@;
	;;
	"up_lv_to")
	#
	_bot_check_and_up_lv $@;
	exit $?;
	;;
	"read_mail")
	#
	_bot_mail_handle $@;
	;;
	"join_comp")
	#comp_id
	callStandardApi group_info_join $@;
	;;
	"join_comp_apply")
	#user_id
	callStandardApi group_info_join_check $1;
	;;
	"comp_assign")
	#lv_id user_id
	callStandardApi group_title_give $@;
	;;
	"leave_comp")
	#
	jqPath=$(getJqPath);
	user_id=$(_bot_get_role_data t_role id);

	echo "my id is: $user_id";

	callStandardApi group_role_leave $user_id;
	;;
	*)
	#check event function exist
	if type callEvent_$event | grep -q 'function$' 2>/dev/null; then
		echo "callEvent_$event event function exist.";
	else
		echo "event: $event is not exist.";
		exit 2;
	fi
	callEvent $event $@;
	;;
esac
