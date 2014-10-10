#!/bin/bash

file=$1;
jqPath="./lib/jq";

start_id=2001;
end_id=2100;
interval=100
count_id=0;

. lib/class_game_api.sh
class_game_api;

while read line; do

	parsed_data=$(echo $line|$jqPath -c ".id");
	err=$?;
	id=${parsed_data:1:-1};
	role_name=$(echo $line|$jqPath -c ".role_name");
	role_name=${role_name:1:-1};
	if [ "$err" == "0" ];then
		echo $id;
		res=$(callStandardApi role_refresh $id);
		t_role=$(echo $res|$jqPath ".t_role");

		result=$(echo $t_role|$jqPath -c "{d,id,lv,tp_max,money,gold}");
		echo "$id:$role_name:$result" >> 'ids.rich';
	fi
	# if (($count_id >= $interval));then
	# 	start_id=$(($start_id+$count_id));
	# 	end_id=$(($end_id+$count_id));
	# 	count_id=0;
	# fi
done < $file
