
describe Oystercard do
  max_balance = Oystercard::MAX_BALANCE
  min_fare = Oystercard::MIN_FARE
  fare = min_fare
  
  describe '#balance' do
    it 'should have default value of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should increase the balance by the amount' do
      amount = 20
      expect{ subject.top_up(amount) }.to change{ subject.balance }.by(amount)
    end

    it 'should not allow the balance to go above the maximum allowed' do
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error("Maximum balance #{max_balance} exceeded")
    end
  end

  context 'card balance is topped up' do
    before(:each) { subject.top_up(max_balance) }
  end 

    describe '#touch_in' do
      let(:entry_station) { double :station }
      let(:exit_station) { double :station }
      it 'stores the entry station' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq entry_station
      end

      it 'should not let the user touch in with a balance below the minimum' do
        empty_card = Oystercard.new
        expect{ empty_card.touch_in(station) }.to raise_error "Insufficient funds - balance below #{min_fare}"
      end 
    end

    describe '#touch_out' do
      let(:entry_station) { double :station }
      let(:exit_station) { double :station }
      it 'stores the entry station' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq entry_station
        end

      it 'should deduct the fare from the balance' do 
        expect{ subject.touch_out(fare) }.to change { subject.balance }.by(-fare) 
      end

      let(:entry_station) { double :station }
      let(:exit_station) { double :station }
      it 'should store the exit' do 
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect{subject.exit_station.to eq exit_station }
      end
    end 
end