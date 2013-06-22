# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    title "MyString"
    jtype 1
    desc "MyText"
    coins 1
    expiry "2013-06-22 17:25:05"
    jtime "2013-06-22 17:25:05"
    user_id 1
    grade 1
    status 1
    category "MyString"
    completedby 1
  end
end
