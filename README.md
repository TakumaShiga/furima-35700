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

| Column             | Type     | Options                  |
| ------------------ | -------- | ------------------------ |
| nickname           | string   | null: false              |  
| email              | string   | null: false, unique: true|
| encrypted_password | string   | null: false              |
| family_name        | string   | null: false              |
| first_name         | string   | null: false              |
| family_name_k      | string   | null: false              |
| first_name_k       | string   | null: false              |
| birth_day          | date     | null: false              |

has_many :items, dependent: :destroy
has_many :purchases, dependent: :destroy



## itemsテーブル

| Column             | Type       | Options                |
| ------------------ | ---------- | -----------------------|
| name               | string     | null: false            |
| description        | text       | null: false
| price              | integer    | null: false            |
| category_id        | integer    | null: false            |
| condition_id       | integer    | null: false            |
| shipping_burden_id | integer    | null: false            |
| place_id           | integer    | null: false            |
| shipping_date_id   | integer    | null: false            |
| user               | references | foreign_key: true      |

belongs_to :user
has_one :purchase
has_one_attached :image

## purchasesテーブル

| Column             | Type       | Options                |
| ------------------ | ---------- | -----------------------|
| item               | references | foreign_key: true      |
| user               | references | foreign_key: true      |

belongs_to :user
belongs_to :item
has_one :address

## addressesテーブル 

| Column             | Type       | Options                |
| ------------------ | ---------- | -----------------------|
| postal_code        | string     | null: false            |
| prefecture_id      | integer    | null: false            |
| city               | string     | null: false            |
| house_number       | string     | null: false            |
| building_name      | string     |                        |
| phone_number       | string     | null: false            |
| purchase           | references | foreign_key: true      |

belongs_to :purchase