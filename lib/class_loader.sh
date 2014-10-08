
# dependency:
# class_parser

class_loader(){

	#load config to global array
	function load_config(){
		local file=$1;
		local global_var;
		if [ "$2" == "" ];then
			global_var=__g;
		else
			global_var=$2;
		fi

		if [ -f "$file" ];then
			parse_config "$file" "$global_var";
			echo "load $1";
			return 0;
		else
			echo "$file not exist.";
			return 2;
		fi;
	}

	function reload_config(){
		local err;
		load_config $@;
		err=$?;
		return $err;
	}

	function reload_config_all(){
		#load global default settings.
		reload_global_config

		#load bot file to overwrite global default setting.
		reload_bot_config;

		reload_item_config;
	}

	function reload_global_config(){
		local file=config/global.default;
		reload_config $file;
	}

	function reload_bot_config(){
		local file=${__g[bot_config_path]};
		if [ -f $file ];then
			reload_config $file;
		else
			echo "bot config file not exist.";
		fi
	}

	function reload_counter_config(){
		local file=config/counter.default;
		reload_config $file;
	}

	function reload_item_config(){
		reload_config config/item_names __item;
		reload_config config/item_price __price;
	}

}