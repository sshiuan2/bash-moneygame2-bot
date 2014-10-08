
class_bot_event_handler(){

	function beforeCallEvent(){
		local todo;
	}
	function callEvent(){
		beforeCallEvent;

		callEvent_$1 $@;

		afterCallEvent;
	}
	function afterCallEvent(){
		local todo;
	}

	function callEvent_TM_Entrust_Sell(){
		local jqPath=$(getJqPath);
		local res=$(callStandardApi $@);
		local pattern='.list[]|{price:.price,count:.count,id:.id}';
		local checker=$(echo $res|$jqPath -e ".msg" 2>/dev/null);
		checker=${checker:1:-1};
		local err=$?;
		local money;
		case $checker in
			"y")
			#
			money=$(echo $res|$jqPath -e ".bill" 2>/dev/null);
			err=$?;
			money=${money:1:-1};
			money=${money##*_};
			;;
			*)
			#
			money=0;
			;;
		esac
		echo $money;
		return $err;
	}
	function callEvent_market_buy_list(){
		local response=$(callStandardApi $@);
		local pattern='.list[]|{price:.price,count:.count,id:.id}';
		echo $response|$(getJqPath) -e "$pattern" 2>/dev/null;
		return $?;
	}
	function callEvent_market_sell_list(){
		callEvent_market_buy_list $@
	}
	function callEvent_adventure_run(){
		local api=$1;
		local res=$(callStandardApi $api ${__g[adventure_area]} ${__g[adventure_stage]} ${__g[adventure_mode]});
		echo $res;
		#todo auto sell item;
	}
}