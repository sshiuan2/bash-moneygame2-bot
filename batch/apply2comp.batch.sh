#!/bin/bash

. ../lib/class_parser.sh;
. ../lib/class_loader.sh;
. ../lib/class_game_api.sh;

class_parser;
class_loader;
class_game_api;
class_game_api_var_counter_name=__g;
declare -A __g;

comp_id=$1;

start_id=20;
end_id=100;

for ((i=$start_id;i<=$end_id;i++));do
	file_path="bot/$i";
	parse_config $file_path __g;
	callStandardApi group_info_join $comp_id;
done
