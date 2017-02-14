require 'spec_helper'

describe FactoryGirl::SeedGenerator do
  let(:klass) { FactoryGirl::SeedGenerator }
  it do
    seeded = seed(:user)
    expect(seeded).to eq(seed(:user))
  end

  describe "create" do
    it "seeds with custom attributes" do
      seed = klass.create(:user, name: 'John')
      expect(seed.name).to eql 'John'
    end

    it "seeds with traits" do
      seed = klass.create(:user, :david)
      expect(seed.name).to eql 'David'
    end

    it "seeds with attributes and traits" do
      seed = klass.create(:user, :david, nickname: 'Goliath')
      expect(seed.name).to eql 'David'
      expect(seed.nickname).to eql 'Goliath'
    end
  end
end

describe FactoryGirl do
  describe ".seed" do
    it do
      expect(FactoryGirl.seed(:user)).to be
    end

    it do
      expect(FactoryGirl.seed(:user, name: "dev").name).to eq("dev")
    end
  end
end
