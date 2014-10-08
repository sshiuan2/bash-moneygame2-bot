#!/bin/bash

###############
# import libs #
###############

. lib/class_text.sh;
. lib/class_parser.sh;
. lib/class_loader.sh;
. api.sh;
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
class_api;

####################
# global variables #
####################

declare -A __g;
__g[bot_name]=$1;
shift;

__g[bot_config_path]=bot/${__g[bot_name]};

function reload_global_config(){
	reload_config config/global.default;
	echo "reload global config";
}

function reload_bot_config(){
	if [ -f ${__g[bot_config_path]} ];then
		reload_config ${__g[bot_config_path]};
		echo "bot config overwrited";
	else
		echo "bot config file not exist.";
	fi
}

function reload_counter_config(){
	reload_config config/counter.default;
	echo "reload counter config";
}

function reload_item_config(){
	reload_config config/item_names __item;
	reload_config config/item_price __price;
}

function reloadConfig_all(){
	#load global default settings.
	reload_global_config

	#load bot file to overwrite global default setting.
	reload_bot_config;

	reload_item_config;
}

reload_counter_config;
reloadConfig_all;

##########
# getter #
##########

function getJqPath(){
	local path=$(pwd)/lib/jq;
	echo $path;
}

function getDelay(){
	local type=$1;
	local random_range=$((${__g[random_interval]}+1));
	local random=$((RANDOM % $random_range));
	case $type in
		query )
		#
		echo ${__g[query_interval]};
		echo $random;
		;;
		idle )
		#
		echo ${__g[idle_interval]};
		echo $random;
		;;
		*)
		#
		echo 0;
		;;
	esac
}

function getReport(){
	local report;
	local reports;

	echo "$(tput setaf 1)Bot: $(tput setab 7)${__g[bot_name]}$(tput sgr 0)"

	reports=(
		total_adventure_times
		total_callApi_times
		total_callApi_success_times
		total_callApi_fail_times
		);
	for report in ${reports[@]};do
		echo $report : ${__g[$report]};
	done

	reports=(
		total_adventure_money
		total_sell_money
		total_money
		total_exp
		)
	for report in ${reports[@]};do
		echo $report: ${__g[$report]} '=>' $((${__g[$report]}/${__g[total_adventure_times]}));
	done

	reports=(
		total_monsters
		total_items
		)
	for report in ${reports[@]};do
		echo $report: ${__g[$report]} '=>' $((100*${__g[$report]}/${__g[total_adventure_times]}))%;
	done
}

echo "init report test: ";
getReport;

##################
# event handlers #
##################

callEvent_TM_Entrust_Sell(){
	local jqPath=$(getJqPath);
	local res=$(callStandardApi $@);
	local pattern='.list[]|{price:.price,count:.count,id:.id}';
	local checker=$(echo $res|$jqPath -e ".msg" 2>/dev/null);
	checker=${checker:1:-1};
	local err=$?;
	local money;
	case $checker in
		"y")
		#
		money=$(echo $res|$jqPath -e ".bill" 2>/dev/null);
		err=$?;
		money=${money:1:-1};
		money=${money##*_};
		;;
		*)
		#
		money=0;
		;;
	esac
	echo $money;
	return $err;
}
callEvent_market_buy_list(){
	local response=$(callStandardApi $@);
	local pattern='.list[]|{price:.price,count:.count,id:.id}';
	echo $response|$(getJqPath) -e "$pattern" 2>/dev/null;
	return $?;
}
callEvent_market_sell_list(){
	callEvent_market_buy_list $@
}
callEvent_adventure_run(){
	local api=$1;
	local res=$(callStandardApi $api ${__g[adventure_area]} ${__g[adventure_stage]} ${__g[adventure_mode]});
	echo $res;
	#todo auto sell item;
}

##################
# standar handle #
##################

function beforeCallEvent(){
	local todo;
}
function callEvent(){
	beforeCallEvent;

	callEvent_$1 $@;

	afterCallEvent;
}
function afterCallEvent(){
	local todo;
}

##################
# packed methods #
##################

#battle
_bot_vs_monster(){
	local jqPath=$(getJqPath);
	local api=_vslive_run;
	local res;
	local key;
	local monster_id=$1;
	local combo_type=$2;
	local combos;
	local combo;

	case $combo_type in
		"daze")
		#
		combos=(
			normal
			normal
			daze
			normal
			daze
			);
		;;
		"special")
		#
		combos=(
			normal
			normal
			daze
			accuracy
			);
		;;
		"avg")
		#
		combos=(
			normal
			accuracy
			accuracy
			);
		;;
		*)
		#
		combos=(
			normal
			cri
			);
		;;
	esac

	while true ;do
		for combo in ${combos[@]};do
			res=$(callStandardApi $api $monster_id $combo);
			key=$(echo $res|$jqPath ".state[0]");
			key=${key:1:-1};

			echo "bot $combo -> $monster_id";
			echo "boss status: $key";

			case $key in
				win)
				#
				return 0;
				;;
				lose)
				#
				return 2;
				;;
				normal)
				#
				;;
				*)
				#
				echo $res;
				;;
			esac
		done
	done

}

_bot_vs_player(){
	local player_id=;
}

#clean 新手提示
_bot_clear_newbie_notices(){
	local api=role_teach_state;
	local keys=(
		Gdonate_GDinvest
		Gmap
		Gproduct_GPProduct
		Group_frame
		Gsearch_GSgroup
		Gsearch_Gcreate
		Market_frame
		appraise_popup
		home
		item_enhance
		item_equip
		item_item
		mail_mail
		market
		market_popup
		potential
		produce
		pspecial
		);
	local k;
	local value=hide;

	for k in ${keys[@]};do
		callStandardApi $api $k $value;
	done
}

#公司新手任務
_bot_run_guild_newbie_mission(){
	local api;
	local res;
	local err;

	local mission;
	# local missions=(
	# 	'y%40Gmap'
	# 	'y%40Gproduct'
	# 	'y%40Gdonate'
	# 	'y%40n'
	# 	);

	#attr=group_info_join&d=55&id=

	api=role_group_teach_state;
	mission='y%40Gmap';
	callStandardApi $api $mission;

	api=role_group_teach_state;
	mission='y%40Gproduct';
	callStandardApi $api $mission;

	api=group_create_produce;
	item_id=741101;
	callStandardApi $api $item_id;

	api=role_group_teach_state;
	mission='y%40Gdonate';
	callStandardApi $api $mission;

	api=group_donate_stock;
	callStandardApi $api 1;

	api=role_group_teach_state;
	mission='y%40Gmap';
	callStandardApi $api $mission;

	#flow:
	#attr=role_group_teach_state&d=y%40Gmap&id=

	#attr=role_teach_state&d=Gmap&dd=hide&id=
	# {"post":{"attr":"role_teach_state","d":"Gmap","dd":"hide","id":""}

	#attr=role_group_teach_state&d=y%40Gproduct&id=

	#attr=role_teach_state&d=Gproduct_GPProduct&dd=hide&id=
	# {"post":{"attr":"role_teach_state","d":"Gproduct_GPProduct","dd":"hide","id":""}

	#attr=group_create_produce&d=741101&page=n&id=

	#attr=role_group_teach_state&d=y%40Gdonate&id=

	#attr=group_donate_stock&count=1&id=

	#attr=role_group_teach_state&d=y%40n&id=

}

#新手任務
_bot_run_newbie_missions(){
	local api=set_mission;
	local res;

	mission_id=000001;
	res=$(callStandardApi $api $mission_id);
	# {"now_mission":"000002"}
	echo $res;

	local name=${__g[bot_name]};
	_bot_rename $name;

	local mission_ids=(
		000002
		000003
		000004
		000005
		000006
		);
	for mission_id in "${mission_ids[@]}";do
		res=$(callStandardApi $api $mission_id);
		# {"now_mission":"000002"}
		echo $res;
	done
}

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

_bot_loop_set_main_mission(){
	local api=set_main_mission;
	local res;
	local err_msg;

	while true ;do
		res=$(callStandardApi $api main);
		echo $res;
		err_msg=$(echo $res|$jqPath ".msg");
		err_msg=${err_msg:1:-1};
		if [ "$err_msg" != "y" ];then
			break;
		fi
	done
}
_bot_loop_check_achievements_and_get_reward(){
	local api=achieve_set;
	local method=$1;
	local ids=(
		01
		1
		11
		11
		);
	local types=(
		continuepkwin
		pkwin
		);
	####check role_data t_achieve
	# continuepkwin: "1"
	# d: "34661"
	# daybuy: "1"
	# daysell: "1"
	# defeatmonster: "1"
	# foc: "1"
	# id: "35791"
	# kno: "1"
	# lv: "1"
	# map: "1"
	# pkwin: "1"
	# productmoney: "1"
	# producttp: "1"
	# qui: "1"
	# totalbuy: "1"
	# totalprofit: "1"
	# totalsell: "1"
	# vit: "1"
	case $method in
		all)
		#
		;;
		newbie)
		#
		callStandardApi $api 01 lv;
		callStandardApi $api 1 lv;
		callStandardApi $api 11 continuepkwin;
		callStandardApi $api 11 pkwin;
		;;
	esac
}

_bot_run_newbie_main_missions(){
	local jqPath=$(getJqPath);
	local api;
	local res;
	local err;

	local item_d;
	local adventure_mode=search;

	# newbie main mission flow:
	# mission 1 add potential or lv3?
	# "mission_num":2,"mission_info":"lv_4"
	# "mission_num":3,"mission_info":"item_730101_1" 獵刀
	# "mission_num":6,"mission_info":"qui_2"
	# "mission_num":7,"mission_info":"lv_6"
	# "mission_num":8,"mission_info":"home_7201"

	#try run all level.
	_bot_adventure_complete_map_handle 1 $adventure_mode;

	api=add_potential;
	#add p_840009 first to save tp
	callStandardApi $api p_840009 search;

	_bot_loop_set_main_mission;

	echo "start mission 3 獵刀";
	#must add p_830001 1 to produce 獵刀
	api=add_potential;
	callStandardApi $api p_830001 produce;
	api=produce_create;
	res=$(callStandardApi $api 730101);
	echo $res;
	item_d=$(echo $res|$jqPath '.d');

	_bot_loop_set_main_mission;

	api=equip_input;
	res=$(callStandardApi $api $item_d w);
	echo $res;
	echo "end mission 3";

	_bot_loop_set_main_mission;
	_bot_adventure_complete_map_handle 1 $adventure_mode;

	echo "start mission 6 drink qui_2";
	#main mission: need eat 710601.
	api=value_eat;
	callStandardApi $api 710601 dd;
	echo "end mission 6";

	echo "start mission 8 equip home_7201";
	#main mission: mount furniture
	api=home_input;
	callStandardApi $api 720101;
	echo "end mission 8";

	_bot_loop_set_main_mission;

	_bot_loop_check_achievements_and_get_reward newbie;

}

_bot_run_main_missions(){
	local jqPath=$(getJqPath);
	local api;
	local res;
	local err;

	local adventure_mode=search;

	#try run all level.
	_bot_adventure_complete_map_handle 1 $adventure_mode;

	#check t_role main_mission

	api=mission_talk_state;
	while true ;do
		break;
	done

	#conversations
	api=mission_talk_state;
	callStandardApi $api;

	api=mission_talk_state;
	#0:11:2
	callStandardApi $api "0%3A11%3A2";

	api=mission_talk_state;
	callStandardApi $api 1;

	#---produce a nife (have to)---
	api=mission_talk_state;
	#0:5:1
	callStandardApi $api '0%3A5%3A1';

	api=mission_talk_state;
	#0:9:5
	callStandardApi $api '0%3A9%3A5';
	#---produce a nife end----

	api=mission_talk_state;
	#0:2:0
	callStandardApi $api '0%3A2%3A0';

	api=mission_talk_state;
	#1
	callStandardApi $api 1;

	api=mission_talk_state;
	#0:2:0
	callStandardApi $api '0%3A2%3A0';

	#get https://funto.azurewebsites.net/moneygame2/app/own.php

	#=lv5
	api=mission_talk_state;
	#1
	callStandardApi $api 1;

	#attr=role_rank_func&id=
	#attr=role_rank_func&id=
	#attr=role_rank_func&id=

	api=mission_talk_state;
	#1
	callStandardApi $api 1;

	#main mission: potaintial over 2,
	api=mission_talk_state;
	#1
	callStandardApi $api 1;

	#home_7201
	api=mission_talk_state;
	#0:7:0
	callStandardApi $api '0%3A7%3A0';

	#attr=mission_talk_state&d=1&id=
	#1

	#map_1_5
	api=mission_talk_state;
	#0:6:0
	callStandardApi $api '0%3A6%3A0';

	#map_2_1
	api=mission_talk_state;
	#0:7:0
	callStandardApi $api '0%3A7%3A0';

	#main mission: get and drink potion
	#for main mission

	api=mission_talk_state;
	#0:7:0
	callStandardApi $api '0%3A7%3A0';

	#map_2_3

}

_bot_register(){
	local jqPath=$(getJqPath);
	local api=login;
	local res;
	local err;

	local account=${__g[bot_name]};
	local password=$1;

	local mission_id;
	local id;
	local bot_config_file;

	#step 1
	res=$(callStandardApi $api $account $password);
	# {id: "xx", mission: "000001"}

	id=$(echo $res|$jqPath .id);
	err=$?;
	id=${id:1:-1}
	# mission_id=$(echo $res|$jqPath .mission);

	bot_config_file="bot/$account";
	if [ -f "$bot_config_file" ];then
		echo "$bot_config_file already exist...";
		echo "please copy the id: $id";
		return 2;
	else
		touch $bot_config_file;
		echo "id=$id" >> $bot_config_file;
	fi

	echo $id;
	return $err;
}

#登入讀檔
_bot_login_touch_files(){
	local url;
	local app_url='https://funto.azurewebsites.net/moneygame2/app';
	local php_url='https://funto.azurewebsites.net/moneygame2/php';
	local params;
	local res;
	local file_name;
	local file_names=(
		'inside.php'
		'explore.php'
		'combat.php'
		popup.php
		home.php
		produce.php
		potential.php
		item.php
		duel.php
		system.php
		invest.php
		news.php
		task.php
		chat.php
		mail.php
		BigEvent.php
		shop.php
		trade.php
		rank.php
		GameTip.php
		photo.php
		role.php
		market.php
		Mstock.php
		Gmarket.php
		Mconduct.php
		dealer.php
		PriorBuy.php
		Gleague.php
		Gfinance.php
		Golder.php
		Gsearch.php
		Gdonate.php
		Gtech.php
		Gbuild.php
		Grevise.php
		Gproduct.php
		Gmap.php
		Gwar.php
		Advertise.php
		);
	for file_name in ${file_names[@]};do
		url="$app_url/$file_name.php";
		res=$(curlWithParams $url);
	done

	url="$php_url/lang.php";
	params='lang=ct';
	res=$(curlWithParams $url $params);

	url="$php_url/lang2.php";
	res=$(curlWithParams $url);

	url="$php_url/StockData.php";
	res=$(curlWithParams $url);

	api=role_data;
	res=$(callStandardApi $api);

	url="$php_url/monster.php";
	res=$(curlWithParams $url);
}

_bot_login_handle(){
	local api;
	api=get_login_bonus;
}

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

_bot_item_handle(){
	local jqPath=$(getJqPath);
	local api;
	local res;
	local msg;

	local method=$1;
	local item_id=$2;
	local count=$3;

	case $method in
		"sell")
		#sell to market
		api=TM_Entrust_Sell;
		local price=${__price[$item_id]};
		local sell_money;
		sell_money=$(callEvent $api $item_id $price $count);
		echo sell money: $sell_money;

		__g[total_sell_money]=$((${__g[total_sell_money]}+$sell_money));
		__g[total_money]=$((${__g[total_money]}+$sell_money));
		;;
		"donate")
		#donate to guild.
		api=group_donate_item;
		res=$(callStandardApi $api $item_id $count);
		echo $res;
		msg=$(echo $res|$jqPath ".msg");
		msg=${msg:1:-1};

		if [ "$msg" != "y" ];then
			if [ "${__g[item_donate_fail_handle]}" == "recycle" ];then
				api=equip_drop;
				callStandardApi $api $item_id default $count all;
			fi
		fi

		;;
		"nothing")
		#
		;;
		*)
		#
		echo "not assign item handle method, sell or donate?".
		exit 2;
		;;
	esac
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

		reloadConfig_all;
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

_bot_daily_handle(){
	local api=get_login_bonus;
	callStandardApi $api;

	_bot_login_handle;
	_bot_vs_player;
}

_bot(){
	local loop=$1;

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

_bot_buy(){
	local api;
	local res;
	local err;

	local item_id=$1;
	local amount=$2;
	if [ "$2" == "" ];then
		amount=1;
	fi

	#buy and use 790103
	local method;

	api=shop_using;
	method=buy;

	res=$(callStandardApi $api $item_id $method $amount);
	err=$?
	echo $res;
	return $err;
}
_bot_eat(){
	local api;
	local res;
	local err;

	local item_id=$1;
	local amount=$2;
	if [ "$2" == "" ];then
		amount=1;
	fi

	api=value_eat;

	res=$(callStandardApi $api $item_id);
	err=$?
	echo $res;
	return $err;
}

_bot_rename(){
	local api=set_name;
	local name=$1;
	local msg=$2;
	local img=$3;
	if [ "$2" == "" ];then
		msg="%3Cpre%3E%3C%2Fpre%3E";
		img="default%40p0000";
	fi
	callStandardApi $api $name $msg $img;
}

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

_bot_get_role_data_useful(){
	#default show useful params.
	local jqPath=$(getJqPath);
	local result=$1;

	local t_role;
	t_role=$(echo $result|$jqPath ".t_role");
	# local hp=$(echo $t_role|$jqPath ".combat_hp");
	local d=$(echo $t_role|$jqPath ".d");
	local money=$(echo $t_role|$jqPath ".money");
	local gold=$(echo $t_role|$jqPath ".gold");
	local tp=$(echo $t_role|$jqPath ".tp_now");
	local tp_max=$(echo $t_role|$jqPath ".tp_max");
	local lv=$(echo $t_role|$jqPath ".lv");
	local exp=$(echo $t_role|$jqPath ".exp_now");
	local exp_max=$(echo $t_role|$jqPath ".exp_max");

	local t_combat;
	t_combat=$(echo $result|$jqPath ".t_combat");
	local hp=$(echo $t_combat|$jqPath ".hp_now");
	local hp_max=$(echo $t_combat|$jqPath ".hp_max");

	echo money: $money;
	echo gold: $gold;
	echo hp: $hp / $hp_max;
	echo tp: $tp / $tp_max;
	echo lv: $lv \($exp / $exp_max\);
	echo user_id: $d;
}

_bot_get_other_role_data(){
	local jqPath=$(getJqPath);
	local api=other_role_data;
	local res;

	local user_id=$1;
	if [ "$2" == "" ];then
		key=role_product_exp;
	else
		key=$2;
	fi

	res=$(callStandardApi $api $user_id);
	echo $res|$jqPath -C ".$key";

}

_bot_get_role_data(){
	local jqPath=$(getJqPath);
	local api=role_data;
	local res;

	local main_key=$1;
	local key=$2;

	local pattern;

	res=$(callStandardApi $api);

	if [ "$main_key" == "" ];then
		_bot_get_role_data_useful "$res";
	else
		if [ "$main_key" == "all" ];then
			pattern='.';
		else
			if [ "$key" == "" ];then
				pattern=".$main_key";
			else
				pattern=".$main_key.$key";
			fi
		fi
		res=$(echo $res|$jqPath "$pattern");
		echo $res;
	fi

	# ElectTime
	# MgEquipInfo
	# achieve_order
	# blood_lastupdate
	# drug_lastupdate
	# group_item
	# hp_lastupdate
	# login_bonus
	# map_war_d
	# mission_state
	# t_achieve
	# t_combat
	# t_elect
	# t_group
	# t_group_balancesheet
	# t_group_income_statement
	# t_group_item_apply
	# t_group_technology
	# t_home
	# t_land
	# t_map
	# t_pk
	# t_potential
	# t_product_default	#身上物品
	# t_product_gold_shop
	# t_product_update	#身上裝備
	# t_proficiency
	# t_record
	# t_role
	# t_role_invest
	# t_role_stock
	# t_role_stock_buy
	# t_role_teach
	# t_set
	# tp_lastupdate
	# vip_sec
}

_bot_get_market_info(){
	local jqPath=$(getJqPath);
	local items=(
		700105
		700205
		700305
		700405
		700505
		710104
		710105
		710204
		710205
		710304
		710305
		710404
		710405
		710504
		710505
		710604
		710605
		);
	local item;
	local api=market_sell_list;
	local res;
	local err;
	for item in ${items[@]};do
		res=`callEvent $api $item`;
		err=$?;
		if [ ! -z "${__item[$item]}" ];then
			item="$item ${__item[$item]}";
		fi

		if [ "$err" == "0" ];then
			echo $item: `echo $res|$jqPath -c -C ".price" 2>/dev/null`;
		else
			echo $item:
		fi;
	done;
}

#set default event
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
