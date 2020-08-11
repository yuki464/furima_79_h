# README

# firuma_79_h
TECH::CHAMPのチーム開発にてチームのみんなと作り上げた某フリマアプリのクローンサイトです 

# 機能
 
三名で制作し、ギリギリ作り上げたのでこだわりの機能や、カリキュラムでの追加機能は現段階では実現できていない
出品、購入、クレジットカードの登録など基本に忠実なフリマクローンでございます


# VERSION
* rails ...'~> 6.0.0' 
* ruby ...'2.6.5'
* gem "haml-rails", ">= 1.0", '<= 2.0.1'
* gem 'font-awesome-sass'
* gem 'active_hash'
* gem 'payjp'
* gem 'carrierwave'
* gem 'fog-aws'
* gem 'mini_magick'
* gem 'ancestry'
* gem 'pry-rails'
* gem 'devise'
* gem 'font-awesome-rails'
* gem 'active_hash'
* gem 'jp_prefecture'
* gem 'jquery-rails'


# ER図
<img src="/erd.png" alt="ER" title="サンプル">
 
## usersテーブル
|Title|Type|Option|
|:---|:---|:---|
|nickname|string|null: false|
|email   |string|null: false|
|password|string|null: false|
|:---|:---|:---|
### Association
- has_many :cards
- has_one :profile
- has_many :items
- accepts_nested_attributes_for :profile
- has_one :sending_destination
- accepts_nested_attributes_for :sending_destination


## itemsテーブル
|Title|Type|Option|
|:---|:---|:---|
|name             |string|null: false|
|introduction     |text|null: false|
|price|integer    |null: false|
|brand            |string|------|
|condition_id     |integer|null: false,foreign_key:true|
|prefecture_id    |integer|null: false|
|preparationday_id|integer|null: false,foreign_key_true|
|category         |refarences|null: false,foreign_key:true|
|user             |refarences|index: true,foreign_key:true|
|buyer_id         |integer|-------|

### Association
- has_many :item_images, dependent: :destroy
- belongs_to :category
- belongs_to :user
- belongs_to_active_hash :condition
- belongs_to_active_hash :postagepayer
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :size
- belongs_to_active_hash :preparationday


## categoryテーブル
|Title|Type|Option|
|:---|:---|:---|
|name|string|null:false|
|acenstry|string|-----|
### Association-
- has_many :items
- has_acenstry


## item_imagesテーブル
|Title|Type|Option|
|:---|:---|:---|
|url|string|null:false|
|item|references|null:false,foreign_key: true|

### Association
- has_many :items
## profielsテーブル
|Title|Type|Option|
|:---|:---|:---|
|first_name|string|null:false|
|family_name|string|null:false|
|first_name_kana|string|null:false|
|family_name_kana|string|null:false|
|birthday|data|null:false|
|introduction|text|------|
|avatar|string|-----|
|user|references|null:false,foreign_key:true|

### Association
- belongs_to :user, optional: true


## sending_destinationsテーブル
|Title|Type|Option|
|:---|:---|:---|
|destination_first_name      |string|null:false|
|destination_family_name     |string|null:false|
|destination_first_name_kana |string|null:false|
|destination_family_name_kana|string|null:false|
|post_code                   |integer|Limit:7,null:false|
|prefecture_code             |string|null:false|
|city                        |string|null:false|
|house_number                |string|null:false|
|building_name               |string|null:false|
|phone_number                |string|null:false|
|user                        |references|null:false,foreign_key:true|

### Association
- belongs_to :user, optional: true


## cardsテーブル
|Title|Type|Option|
|:---|:---|:---|
|user|references|null:false,foreign_key:true|
|customer_id    |string|null:false|
|card_id        |string|null:false|

### Association
- belongs_to :user
