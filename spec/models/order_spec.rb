require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Using FactoryBot' do
    context 'with association' do
      it 'creates an order with a customer association' do
        order = create(:order)
        expect(order.description).to match(/Order number/)
        expect(order.customer).to be_a Customer
      end
    end

    context '#create_list' do
      it 'creates multiple records' do
        order = create_list(:order, 3)
        expect{ create_list(:order, 3) }.to change { Order.count }.by 3
      end
    end
  end
end
