#!/bin/bash

class_parser(){

	#parse .config file to global array
	#bash can't declare global variable in function,
	#so need to declare outside first.
	#
	#	declare -A user;
	#usage:
	#	parse_config $file_path $global_array_name
	function parse_config(){
		#$1 config file path
		if [ ! -f "$1" ];then
			echo $1 not a file;
			exit 2;
		fi;

		#$2 global var name
		if [ "$2" == "" ];then
			echo $FUNCNAME missing arg 2;
			exit 2;
		fi;

		local config_path=$1;
		local global_var=$2;

		local line;
		local key;
		local value;

		while read line;do
			#read without comment
			[[ "$line" =~ ^#.*$ ]] && continue

			#read without empty line
			[[  -z "$line" ]] && continue

			key="${line%%=*}";
			if [ "$key" != "" ];then
				value="${line##*=}";
				if [ "$value" == "" ];then
					eval "$global_var[$key]=''";
				else
					eval "$global_var[$key]=\"$value\"";
				fi
			fi;
		done < $config_path;
	}

}