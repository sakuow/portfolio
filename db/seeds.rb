# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tagname.create([
  { tag_name: '春'},
  { tag_name: '夏'},
  { tag_name: '秋'},
  { tag_name: '冬'},
  { tag_name: '海'},
  { tag_name: '山'},
  { tag_name: '和'},
  { tag_name: '神社・お寺'},
  { tag_name: '雪'},
  { tag_name: '花火'},
  { tag_name: '外国'},
  { tag_name: '旅行'},
  { tag_name: '川' },
  { tag_name: '街並み'},
  { tag_name: '人混み'},
  { tag_name: '散歩'},
  { tag_name: '祭り'},
  { tag_name: '食べ歩き'},
  { tag_name: '商店街'},
  { tag_name: '路地'},
  { tag_name: '岬'},
])

Admin.create!(
  email: 'a@a',
  password: 'testtest'
)