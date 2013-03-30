require "rspec"
require './lib/core_ext/key_manipulation_hash'


describe "when supplied with no block for conversion" do

  it "should return the original hash unaltered" do
    h={:check=>'data'}
    h.deep_convert_keys().should eq(h)
  end
end

describe "when the hash contains keys that cant be down cased" do

  it "should create an exception" do
    h={:check=>/data/}
    expect{h.keys_to_downcase()}.to raise_error(ArgumentError)
  end
end