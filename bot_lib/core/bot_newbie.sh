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
_bot_run_newbie_guild_mission(){
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