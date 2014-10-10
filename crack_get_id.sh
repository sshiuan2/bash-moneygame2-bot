#!/bin/bash

. lib/class_game_api.sh;
class_game_api;
class_game_api_var_counter_name=__g;
declare -A __g;

. lib/class_crack.sh;
class_crack;

condition=$1;

res=$(crawl_id $condition);
err=$?;
echo $res;
if [ $err != 0 ];then
	exit $err;
fi

jqPath="lib/jq";
id=$(echo $res|$jqPath ".id");
id=${id:1:-1};

res=$(get_important_data_from_id "$id");
echo $res;
