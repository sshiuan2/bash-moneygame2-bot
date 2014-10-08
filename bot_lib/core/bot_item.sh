
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