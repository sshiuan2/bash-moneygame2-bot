
#need class_loader

class_loader(){

	function load_config(){
		local file=$1;
		local global_var;
		if [ "$2" == "" ];then
			global_var=__g;
		else
			global_var=$2;
		fi

		if [ ! -f "$file" ];then
			echo $file not exist;
			exit 2;
		fi;
		parse_config "$file" "$global_var";
	}

	function reload_config(){
		load_config $@;
	}

}