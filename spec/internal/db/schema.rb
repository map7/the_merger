ActiveRecord::Schema.define do
  create_table "letters", :force => true do |t|
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "mobile"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "address"
    t.string   "suburb"
    t.string   "state"
    t.string   "postcode"
  end
end
