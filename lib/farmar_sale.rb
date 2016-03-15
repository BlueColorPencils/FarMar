# lib/farmar_sale.rb
class FarMar::Sale
  attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id
  def initialize(hash)
    @id = hash[:id].to_i
    @amount = hash[:amount].to_i
    @purchase_time = hash[:purchase_time]
    @vendor_id = hash[:vendor_id].to_i
    @product_id = hash[:product_id].to_i
  end

  # ID - (Fixnum) uniquely identifies the sale
  # Amount - (Fixnum) the amount of the transaction, in cents (i.e., 150 would be $1.50)
  # Purchase_time - (Datetime) when the sale was completed
  # Vendor_id - (Fixnum) a reference to which vendor completed the sale
  # Product_id - (Fixnum) a reference to which product was sold

  # creates instances (12798) of each row of data in the csv
  # and pushes them into an array -- *blank cells are nil
  def self.all
    sales_info = []
    CSV.foreach("support/sales.csv") do |row|
      info = self.new(id: row[0], amount: row[1], purchase_time: row[2],
      vendor_id: row[3], product_id: row[4])
      sales_info << info
    end
    return sales_info
  end

  def self.find(id)
    self.all.each do |instance|
      if instance.id == id
        return instance
      end
    end
  end

  def vendor
    FarMar::Vendor.all.find {|instance| instance.id == vendor_id}
  end

end
