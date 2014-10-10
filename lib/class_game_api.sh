########
# TODO #
########

#news.php?lang=ch
#/rank.php?attr=read_rank&d=tower_max_layer&dd=0&ddd=5&id=
#tower_max_layer

#attr=shop_order&n1=0&n2=12&id=

#/link.php?attr=pk_info&id=

#invest mail read
#attr=set_read&read=3896091&id=

#脫裝備
#attr=equip_output&d=145151&id=
# {"msg":"y","item_d":2240461,"site":null}
# {"msg":"no_equip"}

#讀adventure地圖
#attr=adventure_info&id=

#公司
#attr=group_manage_set1&salary_rate=1&employ_rate_now=70&stocker_rate_now=15&id=

#讀世界地圖
#attr=mapwar_showMap_me&map_size=5&id=


#看地圖(移動地圖座標)
#attr=mapwar_move&map_size=5&x=13&y=19&id=
# {"x":"12","y":"16","my_land_d":"26518","kind":"space","msg":"y","lastupdate":1134}


#宣戰
#attr=mapwar_declaration&d=26201&id=
# {"msg":"no_map_att_no_time"}
# {"msg":"no_leader"}
# {"msg":"no_map_join"}
# {"msg":"no_map_att_no_space"}

#attr=mapwar_attack&d=normal&id=
# {"att":"none","def":"none","txt":"2_tower_1110_normal_normal;tower_2_196_normal_dynamite","target":"tower","hp_now":509,"hp_max":"5000","lv":"0","msg":"y","lastupdate":20}
# {"att":"win","def":"lose","txt":"2_tower_1116_normal_normal","target":"tower","hp_now":0,"hp_max":"5000","lv":"0","msg":"y","lastupdate":20}

#放棄據點
#attr=drop_land&d=26177&id=

#公司->殖民->移動玩家
#attr=mapwar_move_player&d=26176&id=

#時間到呼叫移動停止
#attr=MoveEnd&x=12&y=21&d=26471&id=

#取消掛賣
#
# {"msg":"no_count"}

#公司->捐獻需求->發布需求
#attr=set_donate_item&kind=70&val=700101_1%3B700102_1%3B700103_1%3B700104_1%3B700105_1%3B700201_1%3B700203_1%3B700204_1%3B700205_1%3B700301_1%3B700302_1%3B700303_1%3B700304_1%3B700305_1%3B700403_1%3B700404_1%3B700405_1%3B700502_1%3B700503_1%3B700504_1%3B700505_1&id=
# attr:set_donate_item
# kind:73 (val前2碼)
# id:
# INSERT INTO group_donate SET group_d=1051, kind="donate", item_num="a", item_need_qun=999, donate=, priority=___

#開放兌換股票
#attr=stock_assign_set&point=9999&id=
# {"msg":"y","Wordkind":"stock_assign_cancel"}

#搜尋公司
#attr=group_info_search&name=aaa&d=1&id=

#公司->貢獻水晶
#attr=group_donate_crystal&count=0&id=
# {"msg":"no_item"}

#使用物品
#attr=shop_used&d=795161&dd=all&id=
# {"bill":"add_tp_200","msg":"y","UseCount":1}
# {"msg":"no_count"}

#使用物品(帶數量)
#使用物品(開寶相)
#attr=shop_used_count&d=795403&count=1&id=
# {"msg":"y","bonus_list":{"bill":"add_791627_1_545851"},"UseCount":"1"}
# SELECT * FROM role_product_gold_shop WHERE id=13031 AND num=790403 AND qun >=a___

#attr=pk_info&id=
# {"score":"2","win":"1","win_continuous":"1","pk_count":"4","rank":"0","lastupdate":301820,"old_record":"win@\u5167\u5fc3\u7684\u6050\u61fc...@0;;","bonus_state":"0","list":{"name":"\u958b\u5bf6\u7bb1","img":"default@p0002","win_continuous":"302","group_name":"YAMI","msg":"","id":"10951","d":1}}

#msg read.(music?)
#attr=sm_set&d=2&dd=2&id=
# UPDATE role_set SET sound=2, music=\' WHERE id=35171___
# {"state":"n","msg":"y","text":"\u975e\u6cd5\u9032\u5165!!"}

#寄信
#attr=write_mail&name=2&subject=%40%40&content=%40%40&id=
# {"msg":"y"}
# {"msg":"no_role"}

class_game_api(){

	class_game_api_var_counter_name="__g";

	function getUserId(){
		local var=$class_game_api_var_counter_name[id];
		local id=${!var};
		echo $id;
	}

	function getUrl(){
		echo "https://funto.azurewebsites.net/moneygame2/php/link.php"
	}

	# function urlencode() {
	# 	# urlencode <string>

	# 	local length="${#1}"
	# 	for (( i = 0; i < length; i++ )); do
	# 		local c="${1:i:1}"
	# 		case $c in
	# 			[a-zA-Z0-9.~_-]) printf "$c" ;;
	# 			#
	# 			*) printf '%%%02X' "'$c"
	# 			#
	# 		esac
	# 	done
	# }

	function urlencode () {
		local tab="`echo -en "\x9"`"
		local i="$@"
		i=${i//%/%25}  ; i=${i//' '/%20} ; i=${i//$tab/%09}
		i=${i//!/%21}  ; i=${i//\"/%22}  ; i=${i//#/%23}
		i=${i//\$/%24} ; i=${i//\&/%26}  ; i=${i//\'/%27}
		i=${i//(/%28}  ; i=${i//)/%29}   ; i=${i//\*/%2a}
		i=${i//+/%2b}  ; i=${i//,/%2c}   ; i=${i//-/%2d}
		i=${i//\./%2e} ; i=${i//\//%2f}  ; i=${i//:/%3a}
		i=${i//;/%3b}  ; i=${i//</%3c}   ; i=${i//=/%3d}
		i=${i//>/%3e}  ; i=${i//\?/%3f}  ; i=${i//@/%40}
		i=${i//\[/%5b} ; i=${i//\\/%5c}  ; i=${i//\]/%5d}
		i=${i//\^/%5e} ; i=${i//_/%5f}   ; i=${i//\`/%60}
		i=${i//\{/%7b} ; i=${i//|/%7c}   ; i=${i//\}/%7d}
		i=${i//\~/%7e} 
		echo "$i";
	}

	function curlWithParams(){
		local url=$1;
		local params=$2;
		# echo $params;
		local curl_params="--compressed --silent";
		local headers=(
			"Accept-Encoding: gzip,deflate"
			"Accept-Language: zh-TW,zh;q=0.8,en-US;q=0.6,en;q=0.4"
			"User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537"
			"Accept: application/json, text/javascript, */*; q=0.01"
			"Referer: https://funto.azurewebsites.net/moneygame2/app/"
			"X-Requested-With: XMLHttpRequest"
			"Connection: keep-alive"
			"Cache-Control: no-cache"
			);
		local header;
		local cmd="curl \"${url}?${params}\" $curl_params";
		for header in "${headers[@]}";do
			# echo $header;
			cmd+=" -H \"$header\"";
		done
		response=$(eval $cmd);
		local err=$?;
		echo $response;
		return $err;
	}

	function callStandardApi(){
		local response=$(callApi_$1 $@);
		local err=$?;
		echo $response;
		(($class_game_api_var_counter_name[total_callApi_times]++));
		return $err;
	}

	function callApi_login(){
		local url="https://funto.azurewebsites.net/moneygame2/php/login.php";

		local attr=$1;
		local account=$(urlencode $2);
		local password=$3;

		local server=1;
		local from=funto;
		local reg_state=y;
		local user_login=comp;
		local email='';
		local gender='';
		local fb_name='';
		# local brower='Chrome"%"3BMozilla"%"2F5.0+(Windows+NT+6.1"%"3B+WOW64)+AppleWebKit"%"2F537.36+(KHTML"%"2C+like+Gecko)+Chrome"%"2F37.0.2062.124+Safari"%"2F537.36"';
		local brower='Chrome';
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
		# {"msg":"n","text":"Errop_Password"}
	}

	#改名
	function callApi_set_name(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local name=$2;
		local msg=$3;
		local img=$4;

		local params="attr=${attr}&name=${name}&msg=${msg}&img=${img}&id=${id}";

		local response=$(curlWithParams $url $params);
		local err=$?
		echo $response;
		return $err;
		# {"msg":"y","post":{"attr":"set_name","name":"5","msg":"<pre>5<\/pre>","img":"default@p0000","id":""}}
		# {"msg":"Double_Name","post":{"attr":"set_name","name":"<pre><\/pre>","msg":"<pre><\/pre>","img":"","id":""}}
	}

	#名言->修改
	function callApi_edit_msg(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #msg
		local params="attr=${attr}&d=${d}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y"}
		# UPDATE role SET msg='' WHERE id=35171___
	}

	#新手任務
	function callApi_set_mission(){
		local url=$(getUrl);
		local id=$(getUserId);
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
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #key
		local dd=$3; #hide,

		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
	}

	#公司新手任務
	function callApi_role_group_teach_state(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #key

		local params="attr=${attr}&d=${d}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
	}

	#主線任務
	function callApi_set_main_mission(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local kind=$2;
		local kind2='';
		local params="attr=${attr}&kind=${kind}&kind2=${kind2}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","mission_state":"n","mission_num":2,"mission_info":"lv_4","mission_bonus":"money_5000;700101_6","mission_bonus_extend":0,"bill":"add_795201_2_544771","mission_lastupdate":0,"mission_get":"y"}
		# {"msg":"y","mission_state":"n","mission_num":2,"mission_info":"lv_4","mission_bonus":"money_5000;700101_6","mission_bonus_extend":0,"bill":"add_795201_2_546891","mission_lastupdate":0,"mission_get":"y"}
		# {"msg":"no_safe"}
	}

	#get角色資料
	function callApi_role_data(){
		local url=$(getUrl);
		local attr=$1;
		local id=$2;
		if [ "$2" == "" ];then
			id=$(getUserId);
		else
			id=$2;
		fi

		local params="attr=${attr}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		#UPDATE role SET vip=0 WHERE id=___
	}

	#get其他角色資料
	function callApi_other_role_data(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #user_id

		local params="attr=${attr}&d=${d}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# role: {d:9681, id:10611, img:fb@100008391097050, name:李應慈, vip:4, vip_time:1414171069, server:1,…}
		# role_combat: {d:9671, id:10611, server:1, hp_now:17231, hp_max:17280, att:196, def:183, accuracy:175, dodge:371,…}
		# role_home: {d:9651, id:10611, tp_num:720105, tp_val:900, tp_time:1412763081, hp_num:0, hp_val:0, hp_time:0,…}
		# role_pk: {d:4621, id:10611, server:1, lv:53, score:25, rank:0, pk_count:4, win:142, win_continuous:6,…}
		# role_potential: {d:9651, id:10611, total_money:0, p_810001:0, p_810011:0, p_810003:4, p_810004:4, p_810005:0,…}
		# role_product_exp: {d:9441, id:10611, 7101_lv:1, 7101_exp:0, 7103_lv:4, 7103_exp:52, 7104_lv:5, 7104_exp:0, 7105_lv:1,…}
		# role_product_update: {list:[,…]}
		# role_record: {d:9651, id:10611, server:1, tower_layer:13, tower_max_layer:13, tower_tp:4, tower_monster:1,…}
	}

	#reload角色資料
	function callApi_role_refresh(){
		callApi_role_data $@;
	}

	#頭像角色->能力資訊
	function callApi_role_rank_func(){
		callApi_role_data $@;
		# {"vit":{"base":200},"foc":{"base":0.003},"kno":{"base":0},"qui":{"base":0},"drug_lastupdate":0,"blood_lastupdate":0}
	}

	#get對話
	function callApi_mission_talk_state(){
		callApi_role_data $@;
		# ""
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
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #potential_id
		local dd=$3; #search, produce
		local page=n;

		local params="attr=${attr}&d=${d}&dd=${dd}&page=${page}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","money":0}
		# {"msg":"no_potential"}
		# {"msg":"no_safe"}
		# {"msg":"no_foc"} 點數不足
		# {"msg":"NO DATA\nattr : \nd : p_830001\ndd : produce\npage : n\nid : 8f14e45fceea167a5a36dedd4bea2543\n"}
	}

	#領成就獎勵
	function callApi_achieve_set(){
		local url=$(getUrl);
		local id=$(getUserId);
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

	#領序號獎勵
	function callApi_SYS_keyBonus(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #key

		local params="attr=${attr}&d=${d}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"no_key"}
	}

	#穿裝備
	function callApi_equip_input(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #item_d
		#part on body
		#w: weapon?
		#nw: 
		local dd=$3;

		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","d":145241,"list":[{"d":"2240341","num":"730201","count":"1","lv":"0","state":"w"},{"d":"2240461","num":"730101","count":"1","lv":"0","state":"w"}],"max_page":1,"now_page":1}
		# SELECT * FROM role_product_update WHERE id=35651 AND site=___
	}

	#創立公司
	function callApi_group_info_create(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local name=$2;
		local introduction=$3;

		local salary=$4;
		local employ_rate=$5;
		local stocker_rate=$6;

		local params="attr=${attr}&name=${name}&introduction=${introduction}&salary=${salary}&employ_rate=${employ_rate}&stocker_rate=${stocker_rate}&id=${id}";
	}

	#申請加入公司
	function callApi_group_info_join(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #comp_id 1051

		local params="attr=${attr}&d=${d}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","WordKind":"group_join_y","group_teach":"n"}
		# {"msg":"group_have"}
		# {"msg":"group_over"}
		#SELECT * FROM `group` WHERE d=___
	}

	#公司apply加入
	function callApi_group_info_join_check(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #user_id whom be applied
		local page=1;

		local params="attr=${attr}&d=${d}&page=${page}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"role":{"list":[{"d":"34721","id":"35651","name":"5","lv":"44","group_title":"99","img":"default@p0000","tp_max":"19800","money":"4015464","group_donate":"60","group_login_time":"2014\/10\/05 "},{"d":"34781","id":"35711","name":"4","lv":"34","group_title":"10","img":"default@p0000","tp_max":"20100","money":"14235","group_donate":"0","group_login_time":"2014\/10\/05 "},{"d":"34241","id":"35171","name":"2","lv":"46","group_title":"100","img":"default@p0000","tp_max":"20600","money":"2759286","group_donate":"2147483647","group_login_time":"2014\/10\/05 "},{"d":"34071","id":"35001","name":"0","lv":"30","group_title":"99","img":"default@p0000","tp_max":"90500","money":"392890","group_donate":"1052","group_login_time":"2014\/10\/05 "},{"d":"34321","id":"35251","name":"3","lv":"47","group_title":"99","img":"default@p0000","tp_max":"20000","money":"246081","group_donate":"16479","group_login_time":"2014\/10\/05 "}],"now_page":1,"max_page":1,"wait_count":"0","people_now":"5","people_max":"20"},"role_apply":{"list":"none","now_page":0,"max_page":0,"wait_count":"0","people_now":"5","people_max":"20"},"msg":"y","WordKind":"joinCheck_y"}
		# {"msg":"no_role"}
	}

	#公司->任命
	function callApi_group_title_give(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		#99 90 60 30 20 10
		local d=$2; #permission level
		local dd=$3; #user_id whom be applied

		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y"}
		# {"msg":"group_title_give_over"}
		# {"msg":"leader_no_change"}
	}


	#退出公司
	function callApi_group_role_leave(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #user_id
		local type=leave;
		local page=1;

		local params="attr=${attr}&d=${d}&type=${type}&page=${page}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","WordKind":"leavePeople_y"}
		# {"msg":"group_have"}
		# {"msg":"leader_no_leave"}
	}

	#公司->公司指令->公司公告->(修改)
	function callApi_group_announce(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local post=$2;
		local kind=; #introduction, business_announce, war_announce

		local params="attr=${attr}&post=${post}&kind=${kind}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		#UPDATE `group` SET introduction=''' WHERE d=1051___
	}

	#公司造物品
	function callApi_group_create_produce(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #item_id
		local page=n;

		local params="attr=${attr}&d=${d}&page=${page}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"group_create_cold":"0","group_create_cold_gold":"0","Rate_add":0,"group_item":{"700505":{"0":"114081","d":"114081","1":"1051","group_d":"1051","2":"700505","item_num":"700505","3":"66","item_qun":"66","4":"1412615914","lastupdate":"1412615914"},"700405":{"0":"114101","d":"114101","1":"1051","group_d":"1051","2":"700405","item_num":"700405","3":"148","item_qun":"148","4":"1412620270","lastupdate":"1412620270"},"700301":{"0":"114111","d":"114111","1":"1051","group_d":"1051","2":"700301","item_num":"700301","3":"104","item_qun":"104","4":"1412620283","lastupdate":"1412620283"},"700205":{"0":"114121","d":"114121","1":"1051","group_d":"1051","2":"700205","item_num":"700205","3":"14","item_qun":"14","4":"1412622443","lastupdate":"1412622443"},"700305":{"0":"114131","d":"114131","1":"1051","group_d":"1051","2":"700305","item_num":"700305","3":"25","item_qun":"25","4":"1412623515","lastupdate":"1412623515"},"700401":{"0":"114141","d":"114141","1":"1051","group_d":"1051","2":"700401","item_num":"700401","3":"810","item_qun":"810","4":"1412624301","lastupdate":"1412624301"},"700402":{"0":"114151","d":"114151","1":"1051","group_d":"1051","2":"700402","item_num":"700402","3":"999","item_qun":"999","4":"1412624305","lastupdate":"1412624305"},"700302":{"0":"114161","d":"114161","1":"1051","group_d":"1051","2":"700302","item_num":"700302","3":"155","item_qun":"155","4":"1412624324","lastupdate":"1412624324"},"700501":{"0":"114171","d":"114171","1":"1051","group_d":"1051","2":"700501","item_num":"700501","3":"94","item_qun":"94","4":"1412637047","lastupdate":"1412637047"},"700202":{"0":"114181","d":"114181","1":"1051","group_d":"1051","2":"700202","item_num":"700202","3":"171","item_qun":"171","4":"1412624364","lastupdate":"1412624364"},"700101":{"0":"114191","d":"114191","1":"1051","group_d":"1051","2":"700101","item_num":"700101","3":"84","item_qun":"84","4":"1412624410","lastupdate":"1412624410"},"700102":{"0":"114201","d":"114201","1":"1051","group_d":"1051","2":"700102","item_num":"700102","3":"156","item_qun":"156","4":"1412624468","lastupdate":"1412624468"},"700502":{"0":"114211","d":"114211","1":"1051","group_d":"1051","2":"700502","item_num":"700502","3":"125","item_qun":"125","4":"1412624621","lastupdate":"1412624621"},"700201":{"0":"114221","d":"114221","1":"1051","group_d":"1051","2":"700201","item_num":"700201","3":"63","item_qun":"63","4":"1412637047","lastupdate":"1412637047"},"700105":{"0":"114231","d":"114231","1":"1051","group_d":"1051","2":"700105","item_num":"700105","3":"17","item_qun":"17","4":"1412629575","lastupdate":"1412629575"},"730101":{"0":"114241","d":"114241","1":"1051","group_d":"1051","2":"730101","item_num":"730101","3":"1","item_qun":"1","4":"1412629773","lastupdate":"1412629773"},"710101":{"0":"114251","d":"114251","1":"1051","group_d":"1051","2":"710101","item_num":"710101","3":"2","item_qun":"2","4":"1412629860","lastupdate":"1412629860"},"720401":{"0":"114261","d":"114261","1":"1051","group_d":"1051","2":"720401","item_num":"720401","3":"6","item_qun":"6","4":"1412637047","lastupdate":"1412637047"}},"state":"y","lastupdate":17429,"msg":"y","g_item":{"700201":{"num":700201,"d":"114221","qun":60},"700401":{"num":700401,"d":"114141","qun":798},"710301":{"num":"710301","d":114291,"qun":4}},"item_have_qun":4,"warehouse_now":0,"bill":"add_710301_4_114291","post":{"attr":"group_create_produce","d":"710301","page":"n","id":""}}
		# SELECT * FROM group_donate WHERE group_d=1051 and  item_num=a                      
		#                                                        and  kind="product"         
		#                                                        and  item_need_qun > item_have_qun___
	}

	#公司貢獻換股票
	function callApi_group_donate_stock(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local count=$2; #amount

		local params="attr=${attr}&count=${count}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		#attr=group_donate_stock&count=1&id=
	}

	#公司->增加貢獻度
	function callApi_group_donate_role_add(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #35171
		local dd=$3; #amount
		#local dd=9999;
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
		local id=$(getUserId);
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
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #bond id;
		local page=n;
		local params="attr=${attr}&d=${d}&page=${page}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {"msg":"y","bill":"des_money_750","WordKind":"y_Invest","CountryVal":"country_lv","CountryLv":"1"}
		# {"msg":"InvestRepeat"}
	}

	#信箱->一鍵領取
	function callApi_get_mail_getAttachment_all(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local kind=$2; #normal, trade, interest
		local page=1; #doesn't matter
		local params="attr=${attr}&kind=${kind}&page=${page}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {"msg":"mail_no_bonus"}
	}

	#安裝傢俱
	function callApi_home_input(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local d=$2;

		local params="attr=${attr}&d=${d}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {"d":"34691","id":"35651","tp_num":"720101","tp_val":"100","tp_time":"0:19:44:44:","hp_num":"0","hp_val":"0","hp_time":"0:0:0:0:","learn_num":"720305","learn_time":"0:24:0:0:","learn_val":"150","exp_num":"720405","exp_val":"900","exp_time":"0:23:28:28:","msg":"y"}
		# {"msg":"no_product"}
	}

	#物品->使用(喝藥水)
	function callApi_value_eat(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #item_id
		local dd=$3;
		local page=n;

		local params="attr=${attr}&d=${d}&dd=${dd}&page=${page}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {"kno":{"base":0.5},"qui":{"base":10000},"msg":"y","vit":{"base":200},"foc":{"base":0.003},"exp":{"exp":10.15,"lv":2,"exp_now":0.15},"bill":"add_qui_0.15_2","max":12,"key":"qui","drug_lastupdate":3600,"blood_lastupdate":0}
		# {"msg":"no_info"}
	}

	#物品->回收
	function callApi_equip_drop(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #item_id
		local dd=$3; #item_type default, gold
		local ddd=$4; #amount
		local dddd=$5; #? all,

		local params="attr=${attr}&d=${d}&dd=${dd}&ddd=${ddd}&dddd=${dddd}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;

		# {"state":"add_money_40","list":[{"d":"554851","num":"790521","count":"4","lv":"0","lastupdate":"1412638668","rank":1},{"d":"551021","num":"791121","count":"2","lv":"0","lastupdate":"1412623584","rank":2},{"d":"551061","num":"795302","count":"7","lv":"0","lastupdate":"1412623114","rank":3},{"d":"549221","num":"795201","count":"10","lv":"0","lastupdate":"1412621477","rank":4},{"d":"554401","num":"795303","count":"1","lv":"0","lastupdate":"1412621082","rank":5},{"d":"551001","num":"795301","count":"5","lv":"0","lastupdate":"1412621042","rank":6},{"d":"551041","num":"791521","count":"2","lv":"0","lastupdate":"1412620472","rank":7},{"d":"554391","num":"790571","count":"2","lv":"0","lastupdate":"1412620444","rank":8},{"d":"551031","num":"795511","count":"3","lv":"0","lastupdate":"1412557485","rank":9},{"d":"551051","num":"795404","count":"3","lv":"0","lastupdate":"1412557485","rank":10},{"d":"551081","num":"791221","count":"1","lv":"0","lastupdate":"1412557485","rank":11},{"d":"551091","num":"791421","count":"1","lv":"0","lastupdate":"1412557485","rank":12}],"max_page":2,"now_page":1,"msg":"y"}
	}

	#交易->個人商品->買入
	function callApi_market_buy_run(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #item_id
		local dd=$3; #price 收購價
		local ddd=$4; #amount

		local params="attr=${attr}&d=${d}&dd=${dd}&ddd=${ddd}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {"msg":"y","WordKind":"SendMailY","state":"remain_1_0","bill":"des_money_300","d":2233151,"list_me":"none","list":[{"d":"795911","id":"15741","server":"1","name":"\u9752\u82b1","kind":"1","num":"700401","count":"20","price":"300","group_d":"0","group_rate":"0","EndSec":null,"state":"n","lastupdate":"10\/04"},{"d":"796431","id":"34841","server":"1","name":"Yan Jingming","kind":"1","num":"700401","count":"40","price":"300","group_d":"0","group_rate":"0","EndSec":null,"state":"n","lastupdate":"10\/04"},{"d":"795921","id":"15741","server":"1","name":"\u9752\u82b1","kind":"1","num":"700401","count":"20","price":"300","group_d":"0","group_rate":"0","EndSec":null,"state":"n","lastupdate":"10\/04"}],"now_page":1,"max_page":12}
	}

	#交易->個人商品->賣出
	function callApi_market_sell_run(){
		callApi_market_buy_run $@;
		#  {"msg":"y","state":"remain_0_1","bill":"add_money_0","list_me":{"d":"816031","id":"35171","server":"1","name":"2","kind":"1","num":"700201","count":"1","price":"300","group_d":"0","group_rate":"0","EndSec":null,"state":"n","lastupdate":"10\/09"},"list":"none","now_page":0,"max_page":0}
	}

	#交易->個人商品->經銷賣出
	function callApi_market_sell_run_auto(){
		callApi_market_buy_run $@;
		# {"msg":"y","state":"remain_0_1","bill":"add_money_0","list_me":{"d":"816071","id":"35171","server":"1","name":"2","kind":"1","num":"700401","count":"1","price":"400","group_d":"0","group_rate":"0","EndSec":"1412869715","state":"y","lastupdate":"10\/09"},"list":[{"d":"750501","id":"30061","server":"1","name":"\u6b7b\u4ea1\u4e4b\u63e1","kind":"0","num":"700401","count":"200","price":"70","group_d":"0","group_rate":"0","EndSec":null,"state":"n","lastupdate":"09\/22"}],"now_page":1,"max_page":1}
	}

	#商城買
	function callApi_shop_buy(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #item_id 790604
		local dd=$3; #amount?

		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
	}

	function callApi_shop_silver_buy(){
		callApi_shop_buy $@;
		# {"msg":"y","bill_silver":"des_silver_90","UseCount":1}
		# {"msg":"no_silver"}
	}

	#購買+使用or使用 商城物品
	function callApi_shop_using(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2; #item_id
		local dd=$3; #buy, use
		local ddd=$4; #amount 1
		local dddd=$5; #other

		local params="attr=${attr}&d=${d}&dd=${dd}&ddd=${ddd}&dddd=${dddd}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {msg: "y"}
		# {msg=no_count} 用光
	}

	#公司->貢獻物資
	function callApi_group_donate_item(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local num=$2; #item_id
		local count=$3;
		local params="attr=${attr}&num=${num}&count=${count}&id=${id}";

		local res=$(curlWithParams $url $params);
		echo $res;
		# {"msg":"y","WordKind":"donateItem_y","warehouse_now":0}
	}

	function callApi_TM_Entrust_Sell(){
		local url=$(getUrl);
		local id=$(getUserId);
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
		local id=$(getUserId);
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

	#製造物品
	function callApi_produce_create(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;

		local d=$2;
		local page=n;

		local params="attr=${attr}&d=${d}&page=${page}&id=${id}";

		local response=$(curlWithParams $url $params);
		local err=$?;
		echo $response;
		return $err;
		# {
		# 	"d":"2240461",
		#	"msg":"y",
		# 	"proficiency":{"exp":2,"lv":1,"exp_max":25},
		# 	"WordKind":"SendMailY",
		# 	"add_item":"",
		# 	"player":{"name":"\u98ef\u5305\u5927\u5927","d":1122,"img":"","lv":1},
		# 	"bill":"des_tp_400;des_money_2400",
		# 	"lv":5,
		# 	"exp":80,
		# 	"LvUp_TpAdd":2500,
		# 	"Rate_add":0
		# }
		# {"msg":"no_tp"}
	}

	function callApi_adventure_run(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #area
		local dd=$3; #level
		local ddd=$4; #mode

		local params="attr=${attr}&d=${d}&dd=${dd}&ddd=${ddd}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		#boss
		# {"key":"boss","value":900204,"state":"y","exp":0,"value_ex":{"lv":7,"msg":"y","id":"35651","skill":[["normal",0],["def",15]],"state":"normal","e":{"hp_now":1680,"hp_max":1680,"hp_loss":0,"mp_now":10,"mp_max":100,"d":900204},"m":{"hp_now":"1000","hp_max":"1000","hp_loss":0,"mp_now":10,"mp_max":100},"round":0,"lastupdate":1412437360},"lv":0,"msg":"y","per":100,"venture_times":1,"des_tp":49}
	}

	function callApi_adventure_boss(){
		local url=$(getUrl);
		local id=$(getUserId);
		local attr=$1;
		local d=$2; #area
		local dd=$3; #level

		local params="attr=${attr}&d=${d}&dd=${dd}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {"msg":"y","exp":0,"key":"boss","state":"n","value":900308,"value_ex":{"msg":"y","id":"35171","skill":[["normal",0],["cri",20]],"state":"normal","e":{"hp_now":3360,"hp_max":3360,"hp_loss":0,"mp_now":10,"mp_max":100,"d":900308},"m":{"hp_now":"236","hp_max":"3810","hp_loss":0,"mp_now":10,"mp_max":100},"round":0,"lastupdate":1412506335},"lv":15}
		#boss_id=.value_ex.id
	}

	#adventure_run meet the monster => battle
	function callApi__vslive_run(){
		local url="https://funto.azurewebsites.net/moneygame2/php/_vslive_run.php";
		local id=$(getUserId);
		local attr=$1;
		local ci=$2; #monster id
		#normal=0
		#accuracy=15
		#cri=20
		#slay=30
		#daze=25
		local kind=$3; #skill name
		local params="ci=${ci}&kind=${kind}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		# {msg: "y",e: {hp_now:-182}}
		#normal, win, lose
		# {msg: "y","state":["lose"]}
		# {"msg":"\u975e\u6307\u5b9a\u6280\u80fd"} #非指定技能
	}

	#開競技場
	function callApi_combat_live(){
		local url=$(getUrl);
		local id=$(getUserId);
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
		local id=$(getUserId);
		local ci=$1; #charactor id
		local kind=$2; #normal

		local params="ci=${ci}&kind=${kind}&id=${id}";

		local response=$(curlWithParams $url $params);
		echo $response;
		#normal, win, lose
		# {"state":["lose"]}
		# {msg: "非指定技能"}
	}

}