__DIR__="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)";

###########################
# global getter functions #
###########################

. $__DIR__/lib/class_bot_getter.sh;

class_bot_getter;

##################
# event handlers #
##################

. $__DIR__/lib/class_bot_event_handler.sh;

class_bot_event_handler;

##################
# packed methods #
##################

. $__DIR__/core/bot_get_data.sh;

. $__DIR__/core/bot_login.sh;
. $__DIR__/core/bot_register.sh;

. $__DIR__/core/bot_newbie.sh;

. $__DIR__/core/bot_battle.sh;
. $__DIR__/core/bot_adventure.sh;

. $__DIR__/core/bot_item.sh;
. $__DIR__/core/bot_mail.sh;
. $__DIR__/core/bot_reward.sh;

. $__DIR__/core/bot_mission.sh;
. $__DIR__/core/bot_check.sh;

_bot_rename(){
	local api=set_name;
	local name=$1;
	local msg=$2;
	local img=$3;
	if [ "$2" == "" ];then
		msg="%3Cpre%3E%3C%2Fpre%3E";
		img="default%40p0000";
	fi
	callStandardApi $api $name $msg $img;
}
