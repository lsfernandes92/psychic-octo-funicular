require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'Using FactoryBot' do
    context '#create' do
      it 'creates a customer factory' do
        customer = create(:customer)
        expect(customer.name).not_to be_nil
        expect(customer.email).not_to be_nil
        expect(customer.vip).to eq false
        expect(customer.days_to_pay).to eq 10
      end
    end

    context '#build' do
      it 'builds a customer instance' do
        customer = build(:customer)
        expect(customer.valid?).to eq true
        expect(customer.new_record?).to eq true
      end
    end

    context '#attributes_for' do
      it 'returns a hash of customer attributes' do
        customer_attrs = attributes_for(:customer)
        expect(customer_attrs).to be_a Hash
        expect(Customer.create(customer_attrs)).to be_a Customer
      end
    end

    context 'with factory aliases' do
      it 'creates a customer factory' do
        customer = create(:user)
        expect(customer.name).not_to be_nil
        expect(customer.email).not_to be_nil
        expect(customer.vip).to eq false
        expect(customer.days_to_pay).to eq 10
      end
    end

    context 'overriding attributes' do
      it 'creates a customer with a custom name' do
        customer = create(:customer, name: 'Foo')
        expect(customer.name).to eq 'Foo'
      end
    end

    context 'with inheritance' do
      it 'creates a vip customer' do
        customer = create(:vip_customer)
        expect(customer.vip).to eq true
        expect(customer.days_to_pay).to eq 15
      end
    end

    context 'with transient attribute' do
      it 'creates a trial customer' do
        customer = create(:customer, trial: true)
        expect(customer.vip).to eq false
        expect(customer.days_to_pay).to eq 15
      end
    end

    context 'with has_many associations' do
      it 'creates a customer with orders' do
        customer = create(:customer_with_orders)
        expect(customer.orders.count).to eq 5
      end

      it 'creates a customer with desirable orders quantity' do
        customer = create(:customer_with_orders, orders_count: 3)
        expect(customer.orders.count).to eq 3
      end
    end

    context '#create_pair/#build_pair' do
      it 'create two customers' do
        expect{ create_pair(:customer) }.to change { Customer.count }.by 2
      end
    end

    context '#attributes_for_list' do
      it 'creates an array of attributes hashes' do
        customer_attrs = attributes_for_list(:customer, 2)
        expect(customer_attrs).to be_a Array
        expect(customer_attrs.first).to be_a Hash
        expect{ Customer.create(customer_attrs) }.to change { Customer.count }.by 2
      end
    end 
  end

  context 'Using time helpers' do
    context '#travel_to' do
      it 'creates a customer with specific date' do
        travel_to Time.zone.local(2024, 01, 16) do
          create(:customer)
        end

        expect(Customer.last.created_at).to be < Time.now
      end
    end
  end
end
