require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    it "initializes the name and piece variables" do
      player = Player.new('Ram', '🟡')
      expect(player.name).to eq('Ram')
      expect(player.piece).to eq('🟡')
    end
  end
end