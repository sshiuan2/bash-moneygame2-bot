
class_bot_getter(){

	function getJqPath(){
		local path=$(pwd)/lib/jq;
		echo $path;
	}

	function getDelay(){
		local type=$1;
		local delay;
		local random_range="${__g[random_interval]}";
		local random;
		if [ "$random_range" == "0" ];then
			random=$((RANDOM % 1));
		else
			random=$((RANDOM % $random_range));
		fi
		case $type in
			query )
			#
			delay=$((${__g[query_interval]}+$random));
			;;
			idle )
			#
			delay=$((${__g[idle_interval]}+$random));
			;;
			*)
			#
			delay=0;
			;;
		esac
		echo $delay;
		return 0;
	}

	function getReport(){
		local report;
		local reports;

		echo "$(tput setaf 1)Bot: $(tput setab 7)${__g[bot_name]}$(tput sgr 0)"

		reports=(
			total_adventure_times
			total_callApi_times
			total_callApi_success_times
			total_callApi_fail_times
			);
		for report in ${reports[@]};do
			echo $report : ${__g[$report]};
		done

		reports=(
			total_adventure_money
			total_sell_money
			total_money
			total_exp
			)
		for report in ${reports[@]};do
			echo $report: ${__g[$report]} '=>' $((${__g[$report]}/${__g[total_adventure_times]}));
		done

		reports=(
			total_monsters
			total_items
			)
		for report in ${reports[@]};do
			echo $report: ${__g[$report]} '=>' $((100*${__g[$report]}/${__g[total_adventure_times]}))%;
		done
	}
}