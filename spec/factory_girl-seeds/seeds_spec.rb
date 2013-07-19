require 'spec_helper'

describe FactoryGirl::SeedGenerator do
  it do
    seeded = seed(:user)
    expect(seeded).to eq(seed(:user))
  end
end