
exec_file="./bot.sh";

function read_ids_from_file_and_exec(){
	local exec_file_path=$1;
	local ids_file=$2;
	shift;
	shift;
	local exec_args=$@;
	local cmd;

	if [ ! -f "$exec_file_path" ];then
		echo "$exec_file_path is not a file.";
		return 2;
	fi

	echo "starting batch...";

	while read bot_id;do

		[[ "$bot_id" =~ ^#.*$ ]] && continue
		[[  -z "$bot_id" ]] && continue
		if [ "${#bot_id}" != "32" ];then
			bot_id=${bot_id%%:*};
			if [ "${#bot_id}" != "32" ];then
				echo "$bot_id probably wrong!! ignore it.";
			fi
		fi
		cmd="$exec_file_path $bot_id $exec_args";
		echo $cmd;
		eval $cmd;
	done < "$ids_file"
}

read_ids_from_file_and_exec $exec_file $@;