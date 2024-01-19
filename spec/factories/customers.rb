FactoryBot.define do
  factory :customer, aliases: [:user] do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    vip { false }
    days_to_pay { trial ? 15 : 10 }

    # How to add inheritance
    # You can easily create multiple factories for the same class without
    # repeating common attributes by nesting factories:
    # factory :vip_customer do
    #   vip { true }
    #   days_to_pay { 15 }
    # end

    # How to use transient attributes
    # Transient attributes are attributes only available within the factory
    # definition, and not set on the object being built. This allows for more
    # complex logic inside factories.
    transient do
      trial { false }
    end

    # How to use traits
    # Traits allow you to group attributes together and then apply them
    # to any factory.
    trait :vip do
      vip { true }
      days_to_pay { 15 }
    end

    trait :trial do
      vip { false }
      days_to_pay { 15 }
    end

    factory :vip_customer, traits: [:vip]
    factory :trial_customer, traits: [:trial]

    # How to use callbacks
    # after(:build) { |customer| customer.name.upcase! }

    # How to genarate data from `has_many` associations
    # There are a few ways to generate that and one way can be the following:
    # Link reference: https://github.com/thoughtbot/factory_bot/blob/main/GETTING_STARTED.md#has_many-associations
    factory :customer_with_orders do
      transient do
        orders_count { 5 }
      end

      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.orders_count, customer: customer)
        customer.reload
      end
    end
  end
end
