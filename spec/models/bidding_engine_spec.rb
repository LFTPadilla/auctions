require 'rails_helper'

RSpec.describe BiddingEngine do
  describe '.bid!' do
    let(:seller) { User.create(email: 'a@a', password: '123456') }
    let(:bidder) { User.create(email: 'b@a', password: '123456') }
    let(:auction) { Auction.create(title: 'Any', description: 'foremipsum', start_date: DateTime.now, end_date: DateTime.now + 1.week, user_id: seller.id) }

    it 'create a new bid on auction if bid is bigger than last bid on auction' do
      described_class.bid!(auction, 100, bidder)
      expect(auction.errors).to be_empty

      described_class.bid!(auction, 90, bidder)
      expect(auction.errors[:bid].first).to eq 'Must be bigger than the last bid on the auction'
    end

    it 'cannot create a bid if its an equal amount as the last bid' do
      described_class.bid!(auction, 100, bidder)
      expect(auction.errors).to be_empty

      described_class.bid!(auction, 100, bidder)
      expect(auction.errors[:bid].first).to eq 'Must be bigger than the last bid on the auction'
    end
  end
end
