require 'rails_helper'
require './lib/api_clients/json_placeholder'

RSpec.describe JsonPlaceHolder do
  describe 'Testing with webmock' do
    subject { JsonPlaceHolder.posts }

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

      xit 'returns posts' do
        expect(subject).to be_an Array
        expect(subject.first[:id]).not_to be_nil
        expect(subject.first[:title]).not_to be_nil
        expect(subject.first[:body]).not_to be_nil
      end
    end
  end

  describe 'Testing with VCR' do
    describe '#posts' do
      subject { JSON.parse(JsonPlaceHolder.posts) }

      it 'returns posts', vcr: { cassette_name: 'jsonplaceholder/posts' } do
        expect(subject).to be_an Array
        expect(subject.first['id']).not_to be_nil
        expect(subject.first['title']).not_to be_nil
        expect(subject.first['body']).not_to be_nil
      end

      describe 'match request on body' do
        subject { JSON.parse(JsonPlaceHolder.posts(1)) }

        it 'returns posts', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body] } do
          expect(subject).to be_an Array
          expect(subject.first['id']).not_to be_nil
          expect(subject.first['title']).not_to be_nil
          expect(subject.first['body']).not_to be_nil
        end
      end
    end
  end
end
