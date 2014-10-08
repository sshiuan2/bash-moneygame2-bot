
#登入讀檔
_bot_login_touch_files(){
	local url;
	local app_url='https://funto.azurewebsites.net/moneygame2/app';
	local php_url='https://funto.azurewebsites.net/moneygame2/php';
	local params;
	local res;
	local file_name;
	local file_names=(
		'inside.php'
		'explore.php'
		'combat.php'
		popup.php
		home.php
		produce.php
		potential.php
		item.php
		duel.php
		system.php
		invest.php
		news.php
		task.php
		chat.php
		mail.php
		BigEvent.php
		shop.php
		trade.php
		rank.php
		GameTip.php
		photo.php
		role.php
		market.php
		Mstock.php
		Gmarket.php
		Mconduct.php
		dealer.php
		PriorBuy.php
		Gleague.php
		Gfinance.php
		Golder.php
		Gsearch.php
		Gdonate.php
		Gtech.php
		Gbuild.php
		Grevise.php
		Gproduct.php
		Gmap.php
		Gwar.php
		Advertise.php
		);
	for file_name in ${file_names[@]};do
		url="$app_url/$file_name.php";
		res=$(curlWithParams $url);
	done

	url="$php_url/lang.php";
	params='lang=ct';
	res=$(curlWithParams $url $params);

	url="$php_url/lang2.php";
	res=$(curlWithParams $url);

	url="$php_url/StockData.php";
	res=$(curlWithParams $url);

	api=role_data;
	res=$(callStandardApi $api);

	url="$php_url/monster.php";
	res=$(curlWithParams $url);
}
