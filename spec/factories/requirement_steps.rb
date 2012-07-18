# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :requirement_step do
    requirement_id 1
    step "MyText"
    order 1
  end
end
