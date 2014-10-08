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