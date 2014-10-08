
core_file="bot.sh";

if [ -z "$1" ];then
	bot_from=1;
else
	bot_from=$1;
fi

if [ -z "$1" ];then
	bot_to=1;
else
	bot_to=$2;
fi

name_prefix="b_";
name_subfix="";

password=password;
comp_id=1051;

for (( i = $bot_from; i <= $bot_to; i++ )); do
	bot_name="$nameprefix$i$name_subfix";

	if [ -f "bot/$bot_name" ];then
		echo "bot/$bot_name is already exist.";
		continue;
	fi

	./$core_file $bot_name register $password;

	./$core_file $bot_name newbie;

	#_bot_login_touch_files;

	#maybe is the real register parsing service?
	# https://moneyage2.imoncloud.com:37465/sockjs/info
	# {"websocket":true,"origins":["*:*"],"cookie_needed":false,"entropy":895078671}
	# wss://moneyage2.imoncloud.com:37465/sockjs/363/7o0qt5xc/websocket
	#curl "wss://moneyage2.imoncloud.com:37465/sockjs/363/7o0qt5xc/websocket" -H "Pragma: no-cache" -H "Origin: https://funto.azurewebsites.net" -H "Sec-WebSocket-Key: b6McflNdYZOc/G8bD5sWJw==" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36" -H "Upgrade: websocket" -H "Sec-WebSocket-Extensions: permessage-deflate; client_max_window_bits, x-webkit-deflate-frame" -H "Cache-Control: no-cache" -H "Cookie: ic.sess=699182B0-D864-425A-AFEF-F38D22C974C1" -H "Connection: Upgrade" -H "Sec-WebSocket-Version: 13" --compressed

	./$core_file $bot_name newbie_main;

	./$core_file $bot_name buy 790604 1;

	#check lv 10 first
	./$core_file $bot_name up_lv_to 10;
	err=$?;
	if [ "$err" == "0" ];then
		echo 'now lv >= 10, run the guild mission.';
	fi
	./$core_file $bot_name join_comp 55; #飯包大大公會id
	./$core_file $bot_name newbie_guild;

	./$core_file $bot_name main_mission;

	#take potions.
	./$core_file $bot_name eat 710601;
	./$core_file $bot_name eat 710601;
	./$core_file $bot_name eat 710301;
	./$core_file $bot_name eat 710301;

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

	./$core_file $bot_name leave_comp;

	#apply to guild
	./$core_file $bot_name join_comp $comp_id;

done

