FactoryBot.define do
  factory :order do
    # How to use sequence
    sequence(:description) { |n| "Order number - #{n}"}
    
    # The association can be done by one of the following:
    customer
    # Or
    # association :customer, factory: :trial_customer
  end
end
