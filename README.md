
#bot

##download

- bot shell

```
git clone https://github.com/up9cloud/bash-moneygame2-bot.git
```

- jq lib

[jq]

```
wget jq
mv jq lib/
```

##create bot config file

######minimun content
```
#bot setting will overwrite config/global.default.config settings.
id=your_id

```

##usage

```
./bot.sh $bot_id [$cmd] [$arg1] [$arg2] ...
```

[jq]:http://stedolan.github.io/jq/download/
