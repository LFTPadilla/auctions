require 'rails_helper'

RSpec.describe Auction, type: :model do
  let(:seller){
    User.new(email: 'a@a', password:'123456')
  }
  subject {
    described_class.new(title: 'Anything',
                        description: 'Anything',
                        start_date: DateTime.now,
                        end_date: DateTime.now + 1.week,
                        user_id: 1)
  }

  describe 'Associations' do
    it { should belong_to(:user).without_validating_presence }
    it { should have_many(:bids) }
  end

  it 'is valid with valid attributes' do
    auction = Auction.new(title: nil)
    expect(auction).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a description' do
    subject.description = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a start_date' do
    subject.start_date = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a end_date' do
    subject.end_date = nil
    expect(subject).to_not be_valid
  end
end
