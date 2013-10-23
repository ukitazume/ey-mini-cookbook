About
=======

すごい小さい変更用のEngine Yard Cloudの設定を変更するクラウドクックブック


```
$gem install engineyard
$ey login
$ey recipes upload
$ey recipes apply 
```


List
======

## custom_php_ini

php iniを追加するレシピ

How to work
============

```
cookbooks/main/recipes/default.rb
```

が最初に呼ばれる。そこからinclude_recipeされたディレクトリ以下のdefualt.rbが呼び出され実行される。

サーバ上には以下にdns.json(node情報を格納したjson)とcookbooks/が配置されている。

```
/etc/chef-custom/
```

ログは以下

```
/var/log/chef.custom.log
```

直にインスタンスに入って実行するには

```
sudo /usr/local/ey_resin/bin/chef-solo -j /etc/chef-custom/dna.json -c /etc/chef-custom/solo.rb
```




参考
======

https://support.cloud.engineyard.com/entries/22340268?locale=67
