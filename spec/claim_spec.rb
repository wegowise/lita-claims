require 'spec_helper'

describe Claim, lita: true do
  subject { Claim }
  before { subject.create("property", "hannes", "staging") }
  after {
    subject.all.each do |claim|
      Claim.destroy(claim)
    end
  }

  describe '#all' do
    it 'returns all claims' do
      expect(subject.all).to eq(["property_staging"])
    end
  end

  describe '#create' do
    it 'sets the key as the property and the value as the claimer' do
      subject.create('property', 'hannes', 'staging')
      expect(subject.read('property', 'staging')).to eq('hannes')
    end

    it 'uses default as the environment if none is passed on' do
      subject.create('property', 'hannes')
      expect(subject.read('property', 'default')).to eq('hannes')
    end
  end

  describe '#read' do
    it 'returns the claimer for the question' do
      expect(subject.read('property', 'staging')).to eq('hannes')
    end

    it 'returns nil when none is present' do
      expect(subject.read('does_not', 'exist')).to eq(nil)
    end
  end

  describe '#destroy' do
    it 'updates an unclaimed property' do
      subject.create('property', 'hannes')
      subject.destroy('property')
      expect(subject.read('property')).to be_nil
    end
  end

  describe '#exists?' do
    it 'returns true if the property exists' do
      expect(subject.exists?('property', 'staging')).to be true
    end

    it 'returns false if the property does not exist' do
      expect(subject.exists?('property_does_not_exist')).to be false
    end
  end
end
