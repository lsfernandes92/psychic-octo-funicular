require 'rails_helper'
require './lib/api_clients/json_placeholder'

RSpec.describe JsonPlaceHolder do
  subject { JsonPlaceHolder.posts }

  describe 'Testing with webmock' do
    describe '#posts' do
      let(:response_body) do
        [
          {
            'userId': 1,
            'id': 1,
            'title': 'Foo title',
            'body': 'Foo body'
          }
        ]
      end
  
      before do
        stub_request(:get, 'https://jsonplaceholder.typicode.com/posts')
          .to_return(
            status: 200, 
            body: response_body, 
            headers: {}
          )
      end
  
      it 'returns posts' do
        expect(subject).to be_an Array
        expect(subject.first[:id]).not_to be_nil
        expect(subject.first[:title]).not_to be_nil
        expect(subject.first[:body]).not_to be_nil
      end
    end
  end
end