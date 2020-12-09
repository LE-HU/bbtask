require 'swagger_helper'
require 'rails_helper'

RSpec.describe 'users', type: :request do

  path '/users' do

    get('list users') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    post('create user') do
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

      response(201, 'successful') do
        let(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }
        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/users/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      response(200, 'successful') do
        let(:id) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com").id }

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    patch('update user') do
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

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    put('update user') do
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

        after do |example|
          example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        end
        run_test!
      end
    end

    # delete('delete user') do
    #   response(204, 'no_content') do
    #     let!(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }
    #     let!(:id) { user.id }

    #     after do |example|
    #       example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
    #     end
    #     run_test!
    #   end
    # end

    delete('delete user') do
      response(204, 'no_content') do
        let!(:user) { FactoryBot.create(:user, first_name: "testone", last_name: "testone", email: "example1@example.com") }

        it 'deletes an user' do
          expect { delete "/users/#{user.id}" }.to change { User.count }.by(-1)
        end

        # after do |example|
        #   example.metadata[:response][:examples] = { 'application/json' => JSON.parse(response.body, symbolize_names: true) }
        # end
        # run_test!
      end
    end
  end
end
