
#bot

command line tool for [moneygame2]

##download

- bot shell

```
git clone https://github.com/up9cloud/bash-moneygame2-bot.git
```

- [jq] lib for parsing json

```
wget jq
mv jq lib/
```

##create bot config file

######file

bot/bot_file_name

######file content
```
#bot setting will overwrite config/global.default.config settings.
id=your_id

```

##edit global settings
config/*

##help
```
./bot.sh --help
```

#known bugs

##server side bugs
- not check acc and password
- shop_buy 790605(vip5) will cause can't login, need use equip_drop to sell item
- 公司貢獻超過2^64會出錯
- 名字可以重複 so 買賣貨品可以騙

##bot client bugs

[jq]:http://stedolan.github.io/jq/download/
[moneygame2]:https://funto.azurewebsites.net/moneygame2/app/