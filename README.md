# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル

| Column             | Type     | Options                |
| ------------------ | -------- | -----------------------|
| nickname           | string   | null: false            |
| email              | string   | null: false            |
| encrypted_password | integer  | null: false            |
| family_name        | string   | null: false            |
| first_name         | string   | null: false            |
| family_name_k      | string   | null: false            |
| first_name_k       | string   | null: false            |
| birth_day          | integer  | null: false            |

has_many :items, dependent: :destroy
has_many :purchases, dependent: :destroy
has_one :address, dependent: :destroy


## itemsテーブル

| Column             | Type       | Options                |
| ------------------ | ---------- | -----------------------|
| name               | string     | null: false            |
| price              | integer    | null: false            |
| category           | string     | null: false            |
| condition          | string     | null: false            |
| shipping_burden    | string     | null: false            |
| place              | string     | null: false            |
| shipping_date      | integer    | null: false            |
| birth_day          | integer    | null: false            |
| user_id            | references | foreign_key: true      |

belongs_to :user
has_one :purchase
has_one_attached :images

## purchasesテーブル

| Column             | Type       | Options                |
| ------------------ | ---------- | -----------------------|
| item_id            | references | foreign_key: true      |
| user_id            | references | foreign_key: true      |

belongs_to :user
belongs_to :item
has_one :address

## addressesテーブル 

| Column             | Type       | Options                |
| ------------------ | ---------- | -----------------------|
| postal_code        | string     | null: false            |
| prefecture         | string     | null: false            |
| city               | string     | null: false            |
| house_number       | integer    | null: false            |
| building_name      | string     | null: false            |
| phone_number       | integer    | null: false            |
| user_id            | references | foreign_key: true      |
| purchase_id        | references | foreign_key: true      |

belongs_to :user
belongs_to :purchase