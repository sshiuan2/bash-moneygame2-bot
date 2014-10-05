########
# TODO #
########

#news.php?lang=ch
#/rank.php?attr=read_rank&d=tower_max_layer&dd=0&ddd=5&id=
#/link.php?attr=pk_info&id=

#invest mail read
#attr=set_read&read=3896091&id=

#物品->使用(喝藥水)
#attr=value_eat&d=710305&dd=dd&page=n&id=

#交易->個人商品->買入
#attr=market_buy_run&d=700401&dd=300&ddd=1&id=
# {"msg":"y","WordKind":"SendMailY","state":"remain_1_0","bill":"des_money_300","d":2233151,"list_me":"none","list":[{"d":"795911","id":"15741","server":"1","name":"\u9752\u82b1","kind":"1","num":"700401","count":"20","price":"300","group_d":"0","group_rate":"0","EndSec":null,"state":"n","lastupdate":"10\/04"},{"d":"796431","id":"34841","server":"1","name":"Yan Jingming","kind":"1","num":"700401","count":"40","price":"300","group_d":"0","group_rate":"0","EndSec":null,"state":"n","lastupdate":"10\/04"},{"d":"795921","id":"15741","server":"1","name":"\u9752\u82b1","kind":"1","num":"700401","count":"20","price":"300","group_d":"0","group_rate":"0","EndSec":null,"state":"n","lastupdate":"10\/04"}],"now_page":1,"max_page":12}

#安裝傢俱
#attr=home_input&d=720305&id=
# {"d":"34691","id":"35651","tp_num":"720101","tp_val":"100","tp_time":"0:19:44:44:","hp_num":"0","hp_val":"0","hp_time":"0:0:0:0:","learn_num":"720305","learn_time":"0:24:0:0:","learn_val":"150","exp_num":"720405","exp_val":"900","exp_time":"0:23:28:28:","msg":"y"}
# {"msg":"no_product"}

#讀adventure地圖
#attr=adventure_info&id=

#battle trigger??

#curl "https://funto.azurewebsites.net/moneygame2/php/link.php?attr=mapwar_attack&d=normal&id=c81e728d9d4c2f636f067f89cc14862c" -H "Cookie: ARRAffinity=7e7f65c30bcc6a76ff8a0b40352fb5ffae847c405ccb4306e0b636a615f1b006; PHPSESSID=jhkg5c2iqhlh98iq2k8ov8mo52" -H "Accept-Encoding: gzip,deflate" -H "Accept-Language: zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36" -H "Accept: application/json, text/javascript, */*; q=0.01" -H "Referer: https://funto.azurewebsites.net/moneygame2/app/" -H "X-Requested-With: XMLHttpRequest" -H "Connection: keep-alive" --compressed

#curl "https://funto.azurewebsites.net/moneygame2/php/link.php?attr=group_manage_set1&salary_rate=1&employ_rate_now=70&stocker_rate_now=15&id=c81e728d9d4c2f636f067f89cc14862c" -H "Cookie: ARRAffinity=7e7f65c30bcc6a76ff8a0b40352fb5ffae847c405ccb4306e0b636a615f1b006; PHPSESSID=jhkg5c2iqhlh98iq2k8ov8mo52" -H "Accept-Encoding: gzip,deflate" -H "Accept-Language: zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36" -H "Accept: application/json, text/javascript, */*; q=0.01" -H "Referer: https://funto.azurewebsites.net/moneygame2/app/" -H "X-Requested-With: XMLHttpRequest" -H "Connection: keep-alive" --compressed

#讀世界地圖
#attr=mapwar_showMap_me&map_size=5&id=
# {
#	center_land: {x:3, y:3},
#	list: [
#		{
		# att_exp_max: "6"
		# att_exp_now: "0"
		# att_group_d: "0"
		# att_group_name: ""
		# att_lv: "0"
		# bonus_count: "10000"
		# bonus_kind: "money"
		# bonus_left: "5000"
		# bonus_rob: "5000"
		# combat_d: "0"
		# combat_lastupdate: "0"
		# cost: "0"
		# d: "26176"
		# def_exp_max: "6"
		# def_exp_now: "0"
		# def_group_d: "0"
		# def_group_name: ""
		# def_lv: "0"
		# group_d: "1041"
		# group_leader: "1"
		# group_name: "<pre>0</pre>"
		# hp_exp_max: "6"
		# hp_exp_now: "0"
		# hp_lv: "0"
		# hp_max: "500000"
		# hp_now: "393852"
		# hp_tag: "42"
		# kind: "castle"
		# mappic: "11"
		# move_people: ""
		# now_people: "3_default@p0000_47_<pre>0</pre>_none_35251"
		# rotate: ""
		# state: ""
		# war_lastupdate: "23311"
		# x: "1"
		# y: "1"
#		}
#	]
# }

#宣戰
#attr=mapwar_declaration&d=26201&id=
# {"msg":"no_map_att_no_time"}
# {"msg":"no_map_join"}

#公司->殖民->移動玩家
#curl "https://funto.azurewebsites.net/moneygame2/php/link.php?attr=mapwar_move_player&d=26176&id=c81e728d9d4c2f636f067f89cc14862c" -H "Cookie: ARRAffinity=7e7f65c30bcc6a76ff8a0b40352fb5ffae847c405ccb4306e0b636a615f1b006; PHPSESSID=jhkg5c2iqhlh98iq2k8ov8mo52" -H "Accept-Encoding: gzip,deflate" -H "Accept-Language: zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36" -H "Accept: application/json, text/javascript, */*; q=0.01" -H "Referer: https://funto.azurewebsites.net/moneygame2/app/" -H "X-Requested-With: XMLHttpRequest" -H "Connection: keep-alive" --compressed

#使用物品
#attr=shop_used&d=795161&dd=all&id=
# {"bill":"add_tp_200","msg":"y","UseCount":1}
# {"msg":"no_count"}
#attr=shop_used&d=795101&dd=all&id=
# {"bill":"add_tp_1000","msg":"y","UseCount":1}

#使用物品(開寶相)
#attr=shop_used_count&d=795403&count=1&id=
# {"msg":"y","bonus_list":{"bill":"add_791627_1_545851"},"UseCount":"1"}

class_api(){

	class_api_var_counter_name="__g";

	function getId(){
		local var=$class_api_var_counter_name[id];
		local id=${!var};
		echo $id;
	}

	function getUrl(){
		echo "https://funto.azurewebsites.net/moneygame2/php/link.php"
	}

	function curlWithParams(){
		local url=$1;
		local params=$2;
		local curl_params="--compressed --silent";

		#-H "Pragma: no-cache"
		#php and .net session are not nessisary.
		#-H "Cookie: ARRAffinity=xxx; PHPSESSID=xxx" \
		local response=$(\
			curl "${url}?${params}" \
			-H "Accept-Encoding: gzip,deflate" \
			-H "Accept-Language: zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4" \
			-H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.124 Safari/537.36" \
			-H "Accept: application/json, text/javascript, */*; q=0.01" \
			-H "Referer: https://funto.azurewebsites.net/moneygame2/app/" \
			-H "X-Requested-With: XMLHttpRequest" \
			-H "Connection: keep-alive" \
			-H "Cache-Control: no-cache" \
			$curl_params
			);
		#
		echo $response;
	}

	function callStandardApi(){
		local response=$(callApi_$1 $@);
		echo $response;
		(($class_api_var_counter_name[total_callApi_times]++));
	}

	function callApi_login(){
		local url="https://funto.azurewebsites.net/moneygame2/php/login.php";
		local account=$1;
		local password=$2;
		local server=1;
		local from=funto;
		local reg_state=y;
		local user_login=comp;
		local email='';
		local gender='';
		local fb_name='';
		local brower='Chrome"%"3BMozilla"%"2F5.0+(Windows+NT+6.1"%"3B+WOW64)+AppleWebKit"%"2F537.36+(KHTML"%"2C+like+Gecko)+Chrome"%"2F37.0.2062.124+Safari"%"2F537.36"';
		local params="account=${account}&password=${password}&server=${server}&from=${from}&reg_state=${reg_state}&user_login=${user_login}&email=${email}&gender=${gender}&fb_name=${fb_name}&brower=${brower}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {
		# 	id: "xx"
		# 	img: ""
		# 	mission: "000001"
		# 	msg: "r"
		# 	role_name: "NoBody"
		# }
	}

	function callApi_set_name(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local name=$2;
		local msg=$3;
		local img=$4;
		local params="attr=${attr}&name=${name}&msg=${msg}&img=${img}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","post":{"attr":"set_name","name":"5","msg":"<pre>5<\/pre>","img":"default@p0000","id":"e4da3b7fbbce2345d7772b0674a318d5"}}
	}

	#新手任務
	function callApi_set_mission(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local mission=$2;

		local params="attr=${attr}&mission=${mission}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","now_mission":"000002"}
	}

	#新手初次提示
	function callApi_role_teach_state(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$2; #key
		local dd=$3; #hide,

		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
	}

	#主線任務
	function callApi_set_main_mission(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local kind=$2;
		local kind2='';
		local params="attr=${attr}&kind=${kind}&kind2=${kind2}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","mission_state":"n","mission_num":2,"mission_info":"lv_4","mission_bonus":"money_5000;700101_6","mission_bonus_extend":0,"bill":"add_795201_2_544771","mission_lastupdate":0,"mission_get":"y"}
		# {"msg":"no_safe"}
	}

	function callApi_role_data(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;

		local params="attr=${attr}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
	}

	#角色資料更新
	function callApi_role_refresh(){
		callApi_role_data $@;
	}

	function callApi_role_rank_func(){
		callApi_role_data $@;
		# {"vit":{"base":200},"foc":{"base":0.003},"kno":{"base":0},"qui":{"base":0},"drug_lastupdate":0,"blood_lastupdate":0}
	}

	#對話
	function callApi_mission_talk_state(){
		callApi_role_data $@;
	}

	#每日獎勵
	function callApi_get_login_bonus(){
		callApi_role_data $@;
		# {"bill":"add_795101_2_544791","msg":"y"}
		# {"msg":"no_data"}
	}

	#加天賦
	function callApi_add_potential(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$2; #potential_id
		local dd=$3; #search, produce
		local page=n;

		local params="attr=&d=${d}&dd=${dd}&page=${page}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","money":0}
		# {"msg":"no_potential"}
		# {"msg":"no_foc"} 點數不足
	}

	#領成就獎勵
	function callApi_achieve_set(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$2;
		local dd=$3; #lv, totalbuy
		local page=n;

		local params="attr=${attr}&d=${d}&dd=${dd}&page=${page}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","lv":{"bill":"add_795301_1_544981","bonus":"795101_1","value":5,"state":"n"}}
		# {"msg":"n"}
	}

	function callApi_group_donate_role_add(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=35171;
		local dd=9999; #amount
		#local dd=65536
		#local dd=16777216;
		#local dd=2147483647;
		#local dd=4294967296;

		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"no_item"}
	}

	#信箱->3
	function callApi_get_invest_mail(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=2; #page
		local params="attr=${attr}&d=${d}&read=&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {state: "n"} => 未投資n,已投資y
		#list: [xxx,bbb]
		#res example
#已投資
# AddMoney: "270"
# BackMoney: "1770"
# ReadState: "1"
# attachment: ""
# begin_sec: "1412259368"
# bonus: "18"
# bonus_max: "0"
# bonus_min: "0"
# cata: "investment"
# cata_id: "665471"
# checks: "0"
# content: "ch&3&0"
# country: "ch"
# d: "3859341"
# end_date: "10/05 12:16"
# end_sec: "1412511368"
# expire_sec: "1412302039"
# expire_time: "10/03 10:07"
# from_id: "0"
# from_name: "ch&3"
# hour: "35"
# id: "35171"
# kind: "3"
# lastupdate: "1412258839"
# lv: "0"
# money: "4500"
# pic: "p1040"
# state: "y"
# times: "2"
# timestamp: "2014-10-04 02:06:20"
# title: "ch&3&0"
# to_id: "35171"
# to_name: "1"
#未投資
# AddMoney: "420"
# BackMoney: "3420"
# ReadState: "0"
# attachment: ""
# begin_sec: "0"
# bonus: "14"
# bonus_max: "0"
# bonus_min: "0"
# cata: "investment"
# cata_id: "670411"
# checks: "0"
# content: "fr&3&0"
# country: "fr"
# d: "3890761"
# end_date: "01/01 00:00"
# end_sec: "0"
# expire_sec: "1412464627"
# expire_time: "10/05 07:17"
# from_id: "0"
# from_name: "fr&3"
# hour: "29"
# id: "35251"
# kind: "3"
# lastupdate: "1412421427"
# lv: "0"
# money: "6000"
# pic: "p1040"
# state: "n"
# times: "2"
# timestamp: "2014-10-04 11:17:08"
# title: "fr&3&0"
# to_id: "35251"
# to_name: "3"
		#
	}

	#信箱->投資->確定
	function callApi_investment_mail_check(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$1; #bond id;
		local page=n;
		local params="attr=${attr}&d=${d}&page=${page}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
	}

	#信箱->一鍵領取
	function callApi_get_mail_getAttachment_all(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local kind=$2; #normal, trade, interest
		local page=1; #doesn't matter
		local params="attr=${attr}&kind=${kind}&page=${page}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
	}

	#商城買
	function callApi_shop_buy(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$1; #item_id 790604
		local dd=$2; #amount?
		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
	}

	#使用or購買商城物品
	function callApi_shop_using(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$2; #item_id
		local dd=$3; #buy, use
		local ddd=$4; #amount 1
		local params="attr=${attr}&d=${d}&dd=${dd}&ddd=${ddd}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {msg: "y"}
		# {msg=no_count} 用光
	}

	function callApi_group_donate_item(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local num=$2; #item_id
		local count=$3;
		local params="attr=${attr}&num=${num}&count=${count}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
	}

	function callApi_TM_Entrust_Sell(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$2; #item_id
		local dd=$3; #price/per
		local ddd; #amount
		if [ "$4" == "" ];then
			ddd=1;
		else
			ddd=$4;
		fi
		local state=y;
		local params="attr=${attr}&d=${d}&dd=${dd}&ddd=${ddd}&state=${state}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {"msg":"y","WordKind":"SendMailY","state":"remain_1_0","bill":"add_money_9500"}
		# {"msg":"y","state":"remain_0_1","bill":"add_money_0"} #掛賣
		# {"msg":"Trade_Need_Over_0"} #item not enough
	}

	function callApi_market_buy_list(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$2; #item_id
		local dd=1;
		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
	}

	function callApi_market_sell_list(){
		callApi_market_buy_list $@;
	}

	function callApi_adventure_run(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local d=$2;
		local dd=$3;
		local ddd=$4;

		local params="attr=${attr}&d=${d}&dd=${dd}&ddd=${ddd}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		#boss
		# {"key":"boss","value":900204,"state":"y","exp":0,"value_ex":{"lv":7,"msg":"y","id":"35651","skill":[["normal",0],["def",15]],"state":"normal","e":{"hp_now":1680,"hp_max":1680,"hp_loss":0,"mp_now":10,"mp_max":100,"d":900204},"m":{"hp_now":"1000","hp_max":"1000","hp_loss":0,"mp_now":10,"mp_max":100},"round":0,"lastupdate":1412437360},"lv":0,"msg":"y","per":100,"venture_times":1,"des_tp":49}
	}

	#adventure_run meet the animal => battle
	function callApi__vslive_run(){
		local url="https://funto.azurewebsites.net/moneygame2/php/_vslive_run.php";
		local id=$(getId);
		local ci=$1; #monster id
		#normal=0
		#accuracy=15
		#cri=25
		#slay=30
		#daze=25
		local kind=$2; #skill name
		local params="ci=${ci}&kind=${kind}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {e: {hp_now:-182}}
		#normal, win, lose
		# {"state":["lose"]}
	}

	#開競技場
	function callApi_combat_live(){
		local url=$(getUrl);
		local id=$(getId);
		local attr=$1;
		local kind=0;

		local params="attr=${attr}&kind=${kind}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		#need parse res to get charactor id
		# {id: "35651"}
	}

	#arena battle
	function callApi__vslive_run_role(){
		local url="https://funto.azurewebsites.net/moneygame2/php/_vslive_run_role.php";
		local id=$(getId);
		local ci=35651; #charactor id
		local kind=normal;

		local params="ci=${ci}&kind=${kind}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		#normal, win, lose
		# {"state":["lose"]}
		# {msg: "非指定技能"}
	}

}