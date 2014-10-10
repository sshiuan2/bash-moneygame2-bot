
_bot_loop_set_main_mission(){
	local api=set_main_mission;
	local res;
	local err_msg;

	while true ;do
		res=$(_bot_set_main_mission);
		echo $res;
		err_msg=$(echo $res|$jqPath ".msg");
		err_msg=${err_msg:1:-1};
		if [ "$err_msg" != "y" ];then
			break;
		fi
	done
	return 0;
}

_bot_set_main_mission(){
	local api=set_main_mission;
	local res;

	res=$(callStandardApi $api main);
	echo $res;
	return 0;
}

_bot_run_main_mission(){
	local mission_id=$1;
	echo "start main mission: $mission_id";
	_bot_set_main_mission;
	_bot_run_main_mission_$mission_id;
	_bot_set_main_mission;
	echo "end main mission: $mission_id";
}

_bot_run_main_mission_1(){
	echo map_1_2;
}
_bot_run_main_mission_2(){
	echo lv_4;
}
_bot_run_main_mission_3(){
	local api;
	local item_d;

	echo item_730101_1;

	#must add p_830001 1 to produce 獵刀
	api=add_potential;
	callStandardApi $api p_830001 produce;
	api=produce_create;
	res=$(callStandardApi $api 730101);
	echo $res;
	item_d=$(echo $res|$jqPath '.d');

	_bot_set_main_mission;

	api=equip_input;
	res=$(callStandardApi $api $item_d w);
	echo $res;
}
_bot_run_main_mission_4(){
	echo "equip_7301 but 3 is done";
}
_bot_run_main_mission_5(){
	echo "lv_5";
}
_bot_run_main_mission_6(){
	local api=value_eat;

	echo qui_2;

	#main mission: need eat 710601.
	callStandardApi $api 710601 dd;
}
_bot_run_main_mission_7(){
	echo "lv_6";
}
_bot_run_main_mission_8(){
	local api=home_input;
	_bot_set_main_mission;

	echo home_7201;
	#main mission: mount furniture
	callStandardApi $api 720101;
}
_bot_run_main_mission_9(){
	echo "map_1_5";
}
_bot_run_main_mission_10(){
	echo "map_2_1";
}
_bot_run_main_mission_11(){
	echo "map_2_3";
}
_bot_run_main_mission_12(){
	echo "map_2_5";
}
_bot_run_main_mission_13(){
	echo "map_3_5";
}
_bot_run_main_mission_14(){
	echo "map_4_5";
}
_bot_run_main_mission_15(){
	echo "map_5_5";
}
_bot_run_main_mission_16(){
	echo "map_6_5";
}
_bot_run_main_mission_17(){
	echo "map_7_5";
}
_bot_run_main_mission_18(){
	echo "map_8_5";
}
_bot_run_main_mission_19(){
	echo "map_9_5";
}
_bot_run_main_mission_20(){
	echo "map_10_5";
}
_bot_run_main_mission_21(){
	echo "map_11_5";
}
_bot_run_main_mission_22(){
	echo "map_12_5";
}
_bot_run_main_mission_23(){
	echo "map_13_5";
}
_bot_run_main_mission_24(){
	echo "map_25_11";
}
_bot_run_main_mission_25(){
	echo "map_25_12";
}
_bot_run_main_mission_26(){
	echo "map_25_13";
}
_bot_run_main_mission_27(){
	echo "map_25_14";
}
_bot_run_main_mission_28(){
	echo "map_25_15";
}
_bot_run_main_mission_29(){
	echo "map_25_16";
}
_bot_run_main_mission_30(){
	echo "map_25_17";
}
_bot_run_main_mission_31(){
	echo "map_25_18";
}
_bot_run_main_mission_32(){
	echo "map_25_19";
}
_bot_run_main_mission_33(){
	echo "map_25_20";
}

_bot_run_newbie_main_missions(){
	local jqPath=$(getJqPath);
	local api;
	local res;
	local err;

	local adventure_mode=search;

	#try run all level.
	_bot_adventure_complete_map_handle 1 $adventure_mode;

	#check .t_role.main_mission
	api=role_refresh;
	res=$(callStandardApi $api);
	mission_id=$(echo $res|$jqPath ".t_role.main_mission");
	mission_id=${mission_id:1:-1};

	if (($mission_id > 8));then
		echo "mission_id is $mission_id, not nessesary go through".
	else
		for ((i=$mission_id;i<=8;i++)); do
			_bot_run_main_mission $i;
		done
	fi
	return 0;
	#following talk is not nessesary.

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