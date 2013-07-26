require 'spec_helper'

describe FactoryGirl::SeedGenerator do
  it do
    seeded = seed(:user)
    expect(seeded).to eq(seed(:user))
  end
end

describe FactoryGirl do
  describe ".seed" do
    it do
      expect(FactoryGirl.seed(:user)).to be
    end
  end
end
