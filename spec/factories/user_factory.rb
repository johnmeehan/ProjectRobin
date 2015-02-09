FactoryGirl.define do
  factory :user do
      name "John"
      password "password"
      email "john@example.com"

      factory :admin_user do
        admin true
      end
    end
end
