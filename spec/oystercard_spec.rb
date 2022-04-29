
describe Station do

  describe 'station' do
    subject {described_class.new}
     it 'knows its name' do                      
       expect(subject.name).to eq("Old Street")              
     end                                           
 
     it 'knows its zone' do                                                     
      expect(subject.zone).to eq(1)                                 
     end
   end 
  end

describe Oystercard do
  max_balance = Oystercard::MAX_BALANCE
  min_fare = Oystercard::MIN_FARE
  fare = min_fare

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end

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
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }
    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
    
    it 'stores a journey' do
      subject.touch_in(entry_station)
      subject.touch_out(fare, exit_station)
      expect(subject.journeys).to include journey
    end

    describe '#touch_in' do  
      it 'stores the entry station' do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq entry_station
      end

      it 'should not let the user touch in with a balance below the minimum' do
        empty_card = Oystercard.new
        expect{ empty_card.touch_in(entry_station) }.to raise_error "Insufficient funds - balance below #{min_fare}"
      end 
    end

    describe '#touch_out' do

      it 'should deduct the fare from the balance' do 
        expect{ subject.touch_out(fare, exit_station) }.to change { subject.balance }.by(-fare) 
      end

      it 'should store the exit station' do 
        subject.touch_in(entry_station)
        subject.touch_out(fare, exit_station)
        expect{subject.exit_station.to eq exit_station }
      end
    end 
  end
end