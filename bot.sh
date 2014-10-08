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
__g[bot_config_path]=bot/${__g[bot_name]};

reload_counter_config;
reload_config_all;

###########################
# load bot packed methods #
###########################

. bot_lib/bot.sh;

_bot_daily_handle(){
	_bot_get_login_reward;
	_bot_vs_player;
}

_bot(){
	local loop=$1;

	echo "init report test: ";
	getReport;

	case $loop in
		"")
		#
		while true;do
			_bot_run_adventure;
			sleep $(getDelay query);
			_bot_daily_handle;
		done;
		;;
		*)
		#
		_bot_daily_handle;
		for [1..$loop..1]; do
			_bot_run_adventure;
			sleep $(getDelay query);
		done
		;;
	esac
}

############
# commands #
############

#set default cmd arg
if [ "$1" == "" ];then
	event=_bot;
else
	event=$1;
	shift;
fi;

case $event in
	"_bot")
	#
	$event $@;
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
	"newbie_main")
	#
	_bot_run_newbie_main_missions;
	;;
	"newbie_guild")
	#
	_bot_run_guild_newbie_mission;
	_bot_daily_handle;
	_bot_mail_handle $@;
	;;
	"main_mission")
	# acc pw
	_bot_run_main_missions $@;
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
	"buy")
	# 790604 1 vip4
	# 790103 1 (12000+)
	# 790113 1 (1500+max)
	_bot_buy $@;
	;;
	"eat")
	#
	_bot_eat $@;
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
	#
	callStandardApi group_info_join $@;
	;;
	"join_comp_apply")
	#todo
	#get user_id
	# callStandardApi group_info_join_check $user_id;
	;;
	"leave_comp")
	#
	jqPath=$(getJqPath);
	user_id=$(_bot_get_role_data t_role id);

	echo "my is: $user_id";

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
