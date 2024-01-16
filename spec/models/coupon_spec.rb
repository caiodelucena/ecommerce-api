require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to define_enum_for(:status).with_values({ active: 1, inactive: 2 }) }
  it { is_expected.to validate_presence_of :discount_value }
  it { is_expected.to validate_numericality_of(:discount_value).is_greater_than(0) }
  it { is_expected.to validate_presence_of :max_use }
  it { is_expected.to validate_numericality_of(:max_use).only_integer.is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_presence_of :due_date }

  it "can't have past due_date" do
    subject.due_date = 1.day.ago
    subject.valid?
    expect(subject.errors.messages[:due_date]).to include('deve ser uma data futura')
  end

  it "can't have current due_date" do
    subject.due_date = DateTime.current
    subject.valid?
    expect(subject.errors.messages[:due_date]).to include('deve ser uma data futura')
  end

  it 'is valid with future due_date' do
    subject.due_date = 1.day.from_now
    subject.valid?
    expect(subject.errors.messages[:due_date]).to_not include('deve ser uma data futura')
  end
end
