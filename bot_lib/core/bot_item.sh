
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
				_bot_drop_item $item_id $count;
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

_bot_trade(){
	local api;
	local res;
	local err;

	local action=$1; #buy or sell
	local item_id=$2;
	local price=$3;
	local amount=$4;

	case $action in
		buy )
		#
		api=market_buy_run;
		;;
		sell )
		#
		api=market_sell_run;
		;;
		auto_sell)
		#
		api=market_sell_run_auto;
		;;
	esac

	res=$(callStandardApi $api $item_id $price $amount);
	err=$?
	echo $res;
	return $err;
}
_bot_buy(){
	local api;
	local res;
	local err;

	local item_id=$1;

	#buy and use 790103
	local method;

	local amount=$2;
	if [ "$2" == "" ];then
		amount=1;
	fi

	#790201 buy 1 other
	local type;

	api=shop_using;
	method=buy;
	type=other;

	res=$(callStandardApi $api $item_id $method $amount $type);
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
	if [ "$amount" == "" ];then
		amount=1;
	fi

	api=value_eat;

	res=$(callStandardApi $api $item_id);
	err=$?
	echo $res;
	return $err;
}
_bot_make(){
	local jqPath=$(getJqPath);
	local api=produce_create;
	local res;
	local err;
	local err_msg;

	local item_id=$1;
	local amount=$2;
	if [ "$amount" == "" ];then
		amount=1;
	fi

	local count=0;
	for ((i=1;i<=$amount;i++)); do
		res=$(callStandardApi $api $item_id);
		err=$?
		echo $res;
		echo "err code: $err";

		# if [ $err != 0 ] ;then
		# 	break;
		# fi

		err_msg=$(echo $res|$jqPath ".msg");
		err_msg=${err_msg:1:-1};

		if [ "$err_msg" != y ];then
			break;
		fi

		((count++));
	done

	echo produced: $item_id x $count;
	return $err;
}
_bot_drop_item(){
	local jqPath=$(getJqPath);
	local api=equip_drop;
	local res;
	local err;

	local item_id=$1;
	local count=$2;

	local item_type=default;
	local handle_type=all;
	res=$(callStandardApi $api $item_id default $count $handle_type);
	echo $res|$jqPath "{state,msg}";
}