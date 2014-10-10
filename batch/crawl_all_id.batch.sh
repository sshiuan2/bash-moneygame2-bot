#!/bin/bash

. ../lib/class_game_api.sh;
class_game_api;
class_game_api_var_counter_name=__g;
declare -A __g;

. ../lib/class_crack.sh;
class_crack;


key=d;

#d 9740~10137
#d 10138~12000

#d 30001~32000
if [ "$1" == "" ];then
	val_from=100000;
else
	val_from=$1;
fi
if [ "$2" == "" ];then
	val_to=110000;
else
	val_to=$2;
fi

log="../data/crawl_all_${key}_form_${val_from}_to_${val_to}";
touch $log;

if [ -f "$log" ];then
	echo "will dump to $log";
else
	exit 2;
fi

for ((i=$val_from;i<=$val_to;i++));do
	condition="${key}%3D${i}";

	res=$(crawl_id $condition);
	err=$?;
	echo "$key => $i";
	echo $res;
	if [ $err == 0 ];then
		echo "${key}=${i}:" >> $log;
		echo $res >> $log;
	else
		echo "${key}=${i}:" >> $log;
		echo "$res" >> $log;
	fi
done

# jqPath="lib/jq";
# id=$(echo $res|$jqPath ".id");
# id=${id:1:-1};

# res=$(get_important_data_from_id "$id");
# echo $res;