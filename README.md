# テーブル設計

## users テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| nickname       | string | null: false |
| email          | string | null: false |
| password       | string | null: false |
| realname       | string | null: false |
| realname(kana) | string | null: false |
| date of birth  | string | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| image       | string     | null: false                    |
| name        | string     | null: false                    |
| description | string     | null: false                    |
| category    | string     | null: false                    |
| condition   | string     | null: false                    |
| deliveryfee | string     | null: false                    |
| area        | string     | null: false                    |
| days        | string     | null: false                    |
| price       | string     | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| information      | string     | null: false                    |
| expiration date  | string     | null: false                    |
| security code    | string     | null: false                    |
| postal code      | string     | null: false                    |
| prefectures      | string     | null: false                    |
| municipality     | string     | null: false                    |
| address          | string     | null: false                    |
| building name    | string     |                                |
| telephone number | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item