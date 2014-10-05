#!/bin/bash

class_text(){

	function text_short_help(){
		local file=$1;
		local cmds=(
			register
			init_all
			newbie
			main_mission
			market
			buy
			me
			mail
			rename
			);
		for c in ${cmds[@]};do
			echo "$1 register";
		done
	}

	function text_help(){
		local file=$1;
		echo 'Known:'
		echo '	<param in this>: essential params';
		echo '	[param in this]: optional params';
		echo 'Usage:'
		echo '	money.sh <$bot_number> [$api_name] [$api_arg1] [$api_arg2]...';
	}
}