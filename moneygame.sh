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

if [ "$1" == "" ];then
	text_usage;
	exit 0;
fi;

class_parser;
class_loader;
class_api;

####################
# global variables #
####################

declare -A __g;
__g[bot_name]=$1;
__g[bot_config_path]=bot/$1;
shift;

function reload_global_config(){
	reload_config config/global.default.config;
	echo "reload global config";
}

function reload_bot_config(){
	reload_config ${__g[bot_config_path]};
	echo "bot config overwrited";
	echo bot_id: ${__g[id]};
}

function reload_counter_config(){
	reload_config config/counter.default.config;
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

getPwd(){
	local path=$(pwd);
	echo $path;
}
getJqPath(){
	local path=$(getPwd)/lib/jq;
	echo $path;
}

function getReport(){
	local report;
	local reports;
	reports=(
		bot_name
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

##################
# event handlers #
##################

callEvent_investment_mail_check(){
	local response=$(callStandardApi $@);
	echo $response;
}
callEvent_get_mail_getAttachment_all(){
	local response=$(callStandardApi $@);
	echo $response;
}
callEvent_group_donate_item(){
	local response=$(callStandardApi $@);
	echo $response;
}
callEvent_TM_Entrust_Sell(){
	local jqPath=$(getJqPath);
	local response=$(callStandardApi $@);
	local pattern='.list[]|{price:.price,count:.count,id:.id}';
	local checker=$(echo $response|$jqPath -e ".msg" 2>/dev/null);
	checker=${checker:1:-1};
	local err=$?;
	local money;
	case $checker in
		"y")
		#
		money=$(echo $response|$jqPath -e ".bill" 2>/dev/null);
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
	local res=$(callStandardApi $1 ${__g[adventure_area]} ${__g[adventure_stage]} ${__g[adventure_mode]});
	echo $res;
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

#clean 新手提示
_bot_clear_newbie_notices(){
	local api=role_teach_state;
	local keys=(
		mail_mail
		Market_frame
		market
		home
		potential
		item_item
		produce
		item_equip
		item_enhance
		Group_frame
		Gproduct_GPProduct

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

_bot_run_newbie_missions(){
	local api;
	local res;
	local name=$1;
	#新手任務
	api=set_mission;
	res=$(callStandardApi $api $mission_id);
	# {"now_mission":"000002"}

	mission_id=000002;

	_bot_rename $name;

	api=set_mission;
	res=$(callStandardApi $api $mission_id);
	# {"msg":"y","now_mission":"000003"}

	mission_id=000003;
	api=set_mission;
	res=$(callStandardApi $api $mission_id);
	# {"msg":"y","now_mission":"000004"}

	mission_id=000004;
	api=set_mission;
	res=$(callStandardApi $api $mission_id);
	# {"msg":"y","now_mission":"000005"}

	mission_id=000005;
	api=set_mission;
	res=$(callStandardApi $api $mission_id);
	# {"msg":"y","now_mission":"000006"}

	mission_id=000006;
	api=set_mission;
	res=$(callStandardApi $api $mission_id);
	# {"msg":"y","now_mission":"000007"}
}

_bot_rename(){
	local api=set_name;
	local name=$1;
	local msg=$2;
	local img=$3;
	if [ "$2" == "" ];then
		msg="%3Cpre%3E$name%3C%2Fpre%3E";
		img="default%40p0000";
	fi
	callStandardApi $api $name $msg $img;
}

_bot_register(){
	local jqPath=$(getJqPath);
	local account=$1;
	local password=$2;
	local api;
	local mission_id;

	local login_res;

	#step 1
	api=login;
	login_res=$(callStandardApi $api $account $password);
	# {id: "xx", mission: "000001"}
	__g[id]=$(echo $login_res|$jqPath .id);
	mission_id=$(echo $login_res|$jqPath .mission);

	_bot_run_newbie_missions $account;

	_bot_clear_newbie_notices;

	#_bot_login_touch_files;

	#maybe is real register parse service?

	# https://moneyage2.imoncloud.com:37465/sockjs/info
	# {"websocket":true,"origins":["*:*"],"cookie_needed":false,"entropy":895078671}

	# wss://moneyage2.imoncloud.com:37465/sockjs/363/7o0qt5xc/websocket
	#curl "wss://moneyage2.imoncloud.com:37465/sockjs/363/7o0qt5xc/websocket" -H "Pragma: no-cache" -H "Origin: https://funto.azurewebsites.net" -H "Sec-WebSocket-Key: b6McflNdYZOc/G8bD5sWJw==" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36" -H "Upgrade: websocket" -H "Sec-WebSocket-Extensions: permessage-deflate; client_max_window_bits, x-webkit-deflate-frame" -H "Cache-Control: no-cache" -H "Cookie: ic.sess=699182B0-D864-425A-AFEF-F38D22C974C1" -H "Connection: Upgrade" -H "Sec-WebSocket-Version: 13" --compressed

	_bot_daily_handle;

	#1-2
	api=adventure_run;
	for i in {1..9..1};do
		callStandardApi $api 1 2 search;
	done

	# api=mission_talk_state;
	# callStandardApi $api;

	#main mission boss
	api=_vslive_run;
	for i in {1..3..1};do
		callStandardApi $api 35651 normal;
	done

	api=set_main_mission;
	callStandardApi $api main;

	#1-2
	api=adventure_run;
	for i in {1..4..1};do
		callStandardApi $api 1 2 search;
	done

	#attr=mission_talk_state&d=0%3A11%3A2&id=
	#0:11:2

	#for main mission
	api=add_potential;
	callStandardApi $api p_840009 search;
	# {"msg":"y"}

	#attr=mission_talk_state&d=1&id=

	#attr=shop_used_count&d=795403&count=1&id=



	#call 7 times
	api=adventure_run;
	for i in {1..7..1};do
		callStandardApi $api 1 3 search;
	done

	#call 6 times
	api=adventure_run;
	for i in {1..6..1};do
		callStandardApi $api 1 4 search;
	done

	api=set_main_mission;
	callStandardApi $api main;

	#attr=mission_talk_state&d=0%3A5%3A1&id=
	#0:5:1

	#must add p_830001 1 to produce nife
	api=add_potential;
	callStandardApi $api p_830001 produce;

	#attr=mission_talk_state&d=0%3A9%3A5&id=
	#0:9:5

	#to create a nife to let achivement done
	#attr=produce_create&d=730101&page=n&id=

	#attr=mission_talk_state&d=1&id=

	api=set_main_mission;
	callStandardApi $api main;

	#attr=mission_talk_state&d=0%3A2%3A0&id=
	#0:2:0

	#attr=equip_input&d=2229071&dd=w&id=
	# {"msg":"y","d":144801,"list":"none","now_page":1,"max_page":1}
	# SELECT * FROM role_product_update WHERE id=35651 AND site=___

	api=set_main_mission;
	callStandardApi $api main;

	#attr=mission_talk_state&d=0%3A2%3A0&id=
	#0:2:0

	#attr=equip_input&d=2229171&dd=w&id=

	#call 2 times
	api=adventure_run;
	for i in {1..2..1};do
		callStandardApi $api 1 4 search;
	done

	api=set_main_mission;
	callStandardApi $api main;

	#get https://funto.azurewebsites.net/moneygame2/app/own.php

	#attr=value_eat&d=710601&dd=dd&page=n&id=

	#attr=mission_talk_state&d=1&id=
	#1

	api=set_main_mission;
	callStandardApi $api main;

	#attr=mission_talk_state&d=1&id=
	#1

	#call 5 times
	api=adventure_run;
	for i in {1..5..1};do
		callStandardApi $api 1 4 search;
	done

	#4 times
	api=_vslive_run;
	callStandardApi $api 35651 normal;
	callStandardApi $api 35651 normal;
	callStandardApi $api 35651 daze;
	callStandardApi $api 35651 accuracy;
	#保險多一次
	callStandardApi $api 35651 normal;

	#call 15 times
	api=adventure_run;
	for i in {1..15..1};do
		callStandardApi $api 1 5 search;
	done

	#1-5 boss
	api=_vslive_run;
	callStandardApi $api 35651 normal;
	callStandardApi $api 35651 normal;
	callStandardApi $api 35651 daze;
	callStandardApi $api 35651 accuracy;
	#保險多一次
	callStandardApi $api 35651 normal;

	#call 4 times
	api=adventure_run;
	for i in {1..4..1};do
		callStandardApi $api 2 1 search;
	done

	#lv6
	api=set_main_mission;
	callStandardApi $api main;

	#set furniture for main mission
	#attr=home_input&d=720101&id=

	#attr=mission_talk_state&d=1&id=
	#1

	api=set_main_mission;
	callStandardApi $api main;

	#attr=mission_talk_state&d=0%3A6%3A0&id=
	#0:6:0

	#main mission: get and drink potion
	api=set_main_mission;
	callStandardApi $api main;

	#attr=mission_talk_state&d=0%3A7%3A0&id=
	#0:7:0

	#for main mission
	#attr=shop_used_count&d=795403&count=1&id=

	#2-1
	api=adventure_run;
	for i in {1..13..1};do
		callStandardApi $api 2 1 search;
	done

	#4 times
	api=_vslive_run;
	callStandardApi $api 35651 normal;
	callStandardApi $api 35651 normal;
	callStandardApi $api 35651 daze;
	callStandardApi $api 35651 accuracy;
	#保險多一次
	callStandardApi $api 35651 normal;

	#after 打倒2-1 boss
	api=set_main_mission;
	callStandardApi $api main;

	api=adventure_run;
	for i in {1..18..1};do
		callStandardApi $api 2 2 search;
	done

	#lv: 7
	#開啟競技場
	#todo 打競技場

	api=achieve_set;
	callStandardApi $api 01 lv;
	api=achieve_set;
	callStandardApi $api 1 lv;
	api=achieve_set;
	callStandardApi $api 11 continuepkwin;
	api=achieve_set;
	callStandardApi $api 11 pkwin;
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
		params='';
		res=$(curlWithParams $url $params);
	done

	url="$php_url/lang.php";
	params='lang=ct';
	res=$(curlWithParams $url $params);

	url="$php_url/lang2.php";
	params='lang=ct';
	res=$(curlWithParams $url $params);

	url="$php_url/StockData.php";
	params='lang=ct';
	res=$(curlWithParams $url $params);

	api=role_data;
	res=$(callStandardApi $api);

	url="$php_url/monster.php";
	res=$(curlWithParams $url $params);
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
	local b;
	local pattern;

	local page=1;
	api=get_invest_mail;
	res=$(callStandardApi $api $page);
	pattern='.list[]|if .state == "n" then .d else empty end';
	bonds=$(echo $res|$jqPath "$pattern");

	api=investment_mail_check;
	for b in ${bonds[@]};do
		res=$(callStandardApi $api ${b:1:-1});
		echo $res;
	done
}

_bot_mail_handle(){
	local event=get_mail_getAttachment_all;
	local api;
	local result;

	echo "start mail handle...";

	result=$(callEvent $event normal);
	echo $result;

	result=$(callEvent $event trade);
	echo $result;

	result=$(callEvent $event interest);
	echo $result;

	_bot_mail_invest_handle;

	echo "end mail handle...";
}

_bot_item_handle(){
	local method=$1;
	local item_id=$2;
	local count=$3;
	local itemHandleEvent;
	local res;

	case $method in
		"sell")
		#sell to market
		itemHandleEvent=TM_Entrust_Sell;
		local price=${__price[$item_id]};
		local sell_money;
		sell_money=$(callEvent_$itemHandleEvent $itemHandleEvent $item_id $price $count);
		echo sell money: $sell_money;

		__g[total_sell_money]=$((${__g[total_sell_money]}+$sell_money));
		__g[total_money]=$((${__g[total_money]}+$sell_money));
		;;
		"donate")
		#donate to guild.
		itemHandleEvent=group_donate_item;
		callEvent_$itemHandleEvent $itemHandleEvent $item_id $count;
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
		echo get item: $item_id x $count '=>' sum: ${__g[total_items]};

		_bot_item_handle ${__g[item_handle]} $item_id $count;
		;;
		"nothing")
		#
		echo "$sub_event";
		;;
		"no_space")
		#
		echo "no space...";
		exit 2;
		;;
		*)
		#
		echo "unknow sub event";
		exit 2;
		;;
	esac
}

_bot_adventure_handle(){
	local checker=$1;
	local jqPath=$(getJqPath);

	#add all fail times 1
	((__g[total_callApi_fail_times]++));
	case $checker in
		"no_tp")
		#
		echo $checker;

		_bot_mail_handle;
		getReport;
		sleep ${__g[idle_interval]};

		reloadConfig_all;
		;;
		"y")
		#
		((__g[total_callApi_fail_times]--));
		((__g[total_callApi_success_times]++));
		((__g[total_adventure_times]++));

		local exp=$(echo $response|$jqPath .exp);
		echo "get exp: $exp";
		__g[total_exp]=$((${__g[total_exp]}+$exp));

		local exp_total=$(echo $response|$jqPath .exp_now);
		echo "total: $exp_total";

		local sub_event=$(echo $response|$jqPath .key);
		sub_event=${sub_event:1:-1};

		_bot_adventure_event_handle $sub_event;
		;;
		*)
		#
		echo "unknown error msg";
		exit 2;
		;;
	esac
}

_bot_daily_handle(){
	local api=get_login_bonus;
	callStandardApi $api;

	_bot_login_handle;
}

_bot(){
	local jqPath=$(getJqPath);
	local response=$(callEvent_adventure_run adventure_run);

	#use jq to parse json.
	local checker=$(echo $response|$jqPath '.msg');
	checker=${checker:1:-1};

	_bot_adventure_handle $checker;
}

_bot_buy(){
	local api;
	local item_id;
	local method;
	local res;
	#buy and use 790103
	api=shop_using;
	item_id=$1;
	method=buy;
	amount=$2;
	if [ "$2" == "" ];then
		amount=1;
	fi

	res=$(callStandardApi $api $item_id $method $amount);
	echo $res;
}

_bot_get_role_data(){
	local jqPath=$(getJqPath);
	local api=role_data;
	local main_key=t_role;
	local key=money;
	local res;
	local result;

	res=$(callStandardApi $api);
	result=$res;

	if [ "$1" == "" ];then
		#default
		result=$(echo $result|$jqPath ".$main_key");
		result=$(echo $result|$jqPath ".$key");
	elif [ "$1" == "all" ];then
		main_key='';
	else
		main_key=$1;
		result=$(echo $result|$jqPath ".$main_key");
	fi

	if [ "$2" == "" ];then
		key='';
	else
		key=$2;
		result=$(echo $result|$jqPath ".$key");
	fi

	echo $result;

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
	# t_product_default
	# t_product_gold_shop
	# t_product_update
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
	local result;
	local err;
	local api=market_sell_list;
	for item in ${items[@]};do
		result=`callEvent_$api $api $item`;
		err=$?;
		if [ ! -z "${__item[$item]}" ];then
			item="$item ${__item[$item]}";
		fi

		if [ "$err" == "0" ];then
			echo $item: `echo $result|$jqPath -c -C ".price" 2>/dev/null`;
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
	while [ "1" = "1" ];do
		$event $@;
		sleep ${__g[query_interval]};
	done;
	;;
	"market")
	#
	_bot_get_market_info $@;
	;;
	"buy")
	# 790103 1
	_bot_buy $@;
	;;
	"me")
	#
	_bot_get_role_data $@;
	;;
	"mail")
	#
	_bot_mail_handle $@;
	;;
	"rename")
	#
	_bot_rename $@;
	;;
	*)
	#check event function exist
	if type callEvent_$event | grep -q 'function$' 2>/dev/null; then
		echo "callEvent_$event event function exist.";
	else
		event=${__g[default_event]};
	fi
	callEvent $event $@;
	;;
esac
