
_bot_register(){
	local jqPath=$(getJqPath);
	local api=login;
	local res;
	local err;

	local account=${__g[bot_name]};
	local password=$1;

	local mission_id;
	local id;
	local bot_config_file;

	#step 1
	res=$(callStandardApi $api $account $password);
	# {id: "xx", mission: "000001"}

	id=$(echo $res|$jqPath .id);
	err=$?;
	id=${id:1:-1}
	# mission_id=$(echo $res|$jqPath .mission);

	bot_config_file="bot/$account";
	if [ -f "$bot_config_file" ];then
		echo "$bot_config_file already exist...";
		echo "please copy the id: $id";
		return 2;
	else
		touch $bot_config_file;
		echo "id=$id" >> $bot_config_file;
	fi

	echo $id;
	return $err;
}
