
_bot_vs_monster(){
	local jqPath=$(getJqPath);
	local api=_vslive_run;
	local res;
	local key;
	local monster_id=$1;
	local combo_type=$2;
	local combos;
	local combo;

	case $combo_type in
		"daze")
		#
		combos=(
			normal
			normal
			daze
			normal
			daze
			);
		;;
		"special")
		#
		combos=(
			normal
			normal
			daze
			accuracy
			);
		;;
		"avg")
		#
		combos=(
			normal
			accuracy
			accuracy
			);
		;;
		*)
		#
		combos=(
			normal
			cri
			);
		;;
	esac

	while true ;do
		for combo in ${combos[@]};do
			res=$(callStandardApi $api $monster_id $combo);
			key=$(echo $res|$jqPath ".state[0]");
			key=${key:1:-1};

			echo "bot $combo -> $monster_id";
			echo "boss status: $key";

			case $key in
				win)
				#
				return 0;
				;;
				lose)
				#
				return 2;
				;;
				normal)
				#
				;;
				*)
				#
				echo $res;
				;;
			esac
		done
	done

}

_bot_vs_player(){
	local player_id=;
}
