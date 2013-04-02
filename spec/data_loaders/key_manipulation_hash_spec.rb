require "rspec"
require './lib/core_ext/key_manipulation_hash'


describe "when supplied with a valid uppercase keyed hash" do

  it "should return the original hash with converted keys" do
    h={"A"=>[{"B"=>1},{"C"=>2}]}
    h=h.keys_to_downcase.keys_to_symbols
    h[:a][0][:b].should == 1
    h[:a][1][:c].should == 2
  end
end


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