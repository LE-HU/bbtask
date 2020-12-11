require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'users', type: :request do

  path '/users' do

    get('list users') do
      tags 'Users'
      produces 'application/json'

      response(200, 'successful') do
        run_test!
      end
    end

    post('create user') do
      tags 'Users'
      produces "application/json"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
                  type: :object,
                  properties: {
                    user: {type: :object, properties: {
                      first_name: {type: :string},
                      last_name: {type: :string},
                      email: {type: :string}
                    }}
                  },
                  required: ['first_name' 'last_name' 'email']
                }

      response(201, 'successful') do
        let(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }
        run_test!
      end

      response(201, 'invalid_request') do
        let(:user) { FactoryBot.create(:user, first_name: "testtwo")}
        run_test! do |response|
          expect(JSON.parse(response.body)["first_name"]).not_to be_falsey
          expect(JSON.parse(response.body)["last_name"]).to be_falsey
          expect(JSON.parse(response.body)["email"]).to be_falsey
        end
      end
    end
  end

  path '/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      tags 'Users'
      produces 'application/json'

      response(200, 'successful') do
        let(:id) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com").id }

        run_test!
      end

      response(404, 'not_found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch('update user') do
      tags 'Users'
      produces "application/json"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {type: :object, properties: {
            first_name: {type: :string},
            last_name: {type: :string},
            email: {type: :string}
          }}
        }
      }
      response(200, 'successful') do
        let(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }
        let(:id) { user.id }

        run_test!
      end

      response(404, 'not_found') do
        let(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put('update user') do
      tags 'Users'
      produces "application/json"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {type: :object, properties: {
            first_name: {type: :string},
            last_name: {type: :string},
            email: {type: :string}
          }}
        }
      }
      response(200, 'successful') do
        let(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }
        let(:id) { user.id }

        run_test!
      end

      response(404, 'not_found') do
        let(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete('delete user') do
      tags 'Users'

      response(204, 'no_content') do
        let(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }
        let!(:id) { user.id }

        run_test!
      end

      response(404, 'not_found') do
        let(:id) { 'invalid' }
        run_test!
      end
    end

  end
end

