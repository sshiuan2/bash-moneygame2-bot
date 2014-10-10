
file_path="../bot.sh";

name_prefix="";
name_subfix="";

password=password;
comp_id=1051;

if [ -z "$1" ];then
	bot_from=1;
else
	bot_from=$1;
fi

if [ -z "$1" ];then
	bot_to=1;
else
	bot_to=$2;
fi

for (( i = $bot_from; i <= $bot_to; i++ )); do
	name=$i;
	bot_name="${name_prefix}${name}${name_subfix}";

	if [ -f "bot/$bot_name" ];then
		echo "bot/$bot_name is already exist.";
		continue;
	fi

	$file_path $bot_name register $password;

	$file_path $bot_name grow_up $@;
done

