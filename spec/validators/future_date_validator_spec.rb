require 'rails_helper'

class Validator
  include ActiveModel::Validations
  attr_accessor :date

  validates :date, future_date: true
end

describe FutureDateValidator do
  subject { Validator.new }
  
  context 'when date is in the past' do
    before { subject.date = 1.day.ago }

    it 'should not be valid' do
      expect(subject.valid?).to be_falsey
    end

    it 'should have an error message' do
      subject.valid?
      expect(subject.errors.messages[:date]).to include('Deve ser uma data futura')
    end
  end

  context 'when date is today' do
    before { subject.date = DateTime.current }

    it 'should not be valid' do
      expect(subject.valid?).to be_falsey
    end
  end

  context 'when date is in the future' do
    before { subject.date = 1.day.from_now }

    it 'should be valid' do
      expect(subject.valid?).to be_truthy
    end
  end
end