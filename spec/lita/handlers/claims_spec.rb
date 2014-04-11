require "spec_helper"

describe Lita::Handlers::Claims, lita_handler: true do
  describe 'routes' do
    it { routes_command('claim property').to :create }
    it { routes_command('claim property environment').to :create }
  end

  describe 'creating claims' do
    it 'replies that the claim was made' do
      send_command 'claim property_x'
      expect(replies.last).to eq('property_x was claimed by Test User')
    end

    it 'replies that the claim was made for a non-default environment' do
      send_command 'claim property_x environment_y'
      expect(replies.last).to eq('property_x (environment_y) was claimed by Test User')
    end

    it 'replies that a claim could not be made because it already exists' do
      Claim.create('property', 'Test User')
      send_command 'claim property'
      expect(replies.last).to eq('Could not claim property - already claimed by Test User')
    end

    it 'replies that a claim could not be made for a non-default environment because it already exists' do
      Claim.create('property', 'Test User', 'env')
      send_command 'claim property env'
      expect(replies.last).to eq('Could not claim property (env) - already claimed by Test User')
    end
  end
end
