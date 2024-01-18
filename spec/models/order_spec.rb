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

  context 'Testing models' do
    subject { build(:order) }

    context 'when is being creating' do
      it 'succeds with valid attributes' do
        expect(subject).to be_valid
        expect{ subject.save }.to change { Order.count }.by(1)
      end
    end

    context 'with validations' do
      it 'validates description presence' do
        subject.description = nil
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages).to match_array(
          ["Description can't be blank"]
        )
      end
    end
  end

  context 'Testing models using shoulda matchers' do
    subject { build(:order) }

    context 'when is being creating' do
      it 'succeds with valid attributes' do
        expect(subject).to be_valid
        expect{ subject.save }.to change { Order.count }.by(1)
      end
    end

    context 'with validations' do
      it { is_expected.to validate_presence_of(:description) }
    end

    context 'with associations' do
      it { is_expected.to belong_to(:customer) }
    end
  end
end
