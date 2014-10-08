
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

	_bot_check_achievements_and_get_reward newbie;

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