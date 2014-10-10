#!/bin/bash

. ../lib/class_game_api.sh;
class_game_api;
class_game_api_var_counter_name=__g;
declare -A __g;

. ../lib/class_crack.sh;
class_crack;

password=password;

dest_file="../data/manual_login.batch.log";

for i in {a..z}; do
	login_and_get_important_data $username $password >> $dest_file;
done