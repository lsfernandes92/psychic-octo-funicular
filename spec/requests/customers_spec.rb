require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  before { create(:customer) }

  describe 'GET #index' do
    before { get customers_path }

    it 'responds successfully' do
      expect(response).to have_http_status :ok
    end
  end
  
  describe 'GET #show' do
    let(:customer_id) { Customer.last.id }

    before { get customer_path(customer_id) }

    it 'returns customers as json' do
      expect(response_body).to be_an Hash 
      expect(response_body).to include_json(
        id: /\d/,
        name: (be_kind_of String),
        email: (be_kind_of String)
      )
    end
  end

  describe 'POST #create' do
    context 'with valid customer' do
      let(:customer_params) do
        attributes_for(
          :customer,
          name: 'Foo name',
          email: 'Foo email'
        )
      end

      before { post(customers_path, params: customer_params) }

      it 'responds with :created' do
        expect(response).to have_http_status :created
      end

      it 'creates customer successfully' do
        expect(response_body).to be_an Hash
        expect(response_body).to include_json(
          id: /\d/,
          name: 'Foo name',
          email: 'Foo email'
        )
      end
    end

    context 'with invalid customer' do
      let(:invalid_customer_params) do
        attributes_for(
          :customer,
          name: '',
          email: ''
        )
      end

      before { post(customers_path, params: invalid_customer_params) }

      it 'responds with :unprocessable_entity' do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'responds with validations' do
        expect(response_body).to include_json(
          name: ["can't be blank"],
          email: ["can't be blank"]
        )
      end
    end
  end
end

private

  def response_body
    JSON.parse(response.body)
  end