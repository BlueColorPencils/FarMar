require_relative 'spec_helper'

describe FarMar::Vendor do
  # make sure there is a Player class
  it "Is there a class? Anything?" do
    FarMar::Vendor.wont_be_nil
  end

  let(:vendors_all) {FarMar::Vendor.all}
  let(:vendors_find) {FarMar::Vendor.find 1}

  # runs the .all method to create instances for each row in vendors.csv
  it "returns total number of vendors => 2690 instances" do
    vendors_all.length.must_equal 2690  # checks the length
  end

  # check the .find(id) method
  it "verifies that the find(id) method returns the correct instance" do
    ven = vendors_find
    ven.id.must_equal 1
    ven.name.must_equal "Feil-Farrell"
    ven.employees.must_equal 8
    ven.market_id.must_equal 1
  end

  # check the market method
  it "verifies the 1 market associated with vendor id: 1" do
    ven_mar = vendors_find.market
    ven_mar.id.must_equal 1
    ven_mar.name.must_equal %q[People's Co-op Farmers Market]
    ven_mar.address.must_equal "30th and Burnside"
    ven_mar.city.must_equal "Portland"
    ven_mar.county.must_equal "Multnomah"
    ven_mar.state.must_equal "Oregon"
    ven_mar.zip.must_equal "97202"
    # included ALL info to refer to for later method testings
  end

  # check the products method
  it "verifies the products (1) associated with vendor id: 1" do
    ven_pro = vendors_find.products[0] # [0] to remove instance from array
    ven_pro.id.must_equal 1
    ven_pro.name.must_equal "Dry Beets"
    ven_pro.vendor_id.must_equal 1
  end

  # check the sales method
  it "should verify all sales (7) found have the vendor id: 1" do
    count = 0
    vendors_find.sales.each do |instance|
      instance.vendor_id.must_equal 1
      count +=1
    end
    count.must_equal 7
  end

  # check the revenue method
  it "should return the sum of all of the vendors sales in cents" do
    vendors_find.revenue.must_equal 38259 # verified with .amounts array in irb
  end

  # check the self.by_market method
  it "should verify all vendors (6) found have the market_id: 1" do
    count = 0
    FarMar::Vendor.by_market(1).each do |instance|
      instance.market_id.must_equal 1
      count += 1
    end
    count.must_equal 6
  end
end
