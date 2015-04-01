require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :name => "MyString",
      :model => "MyString",
      :serial_number => "MyString",
      :mac_address => "MyString",
      :product_code => "MyString",
      :tension_operation => 1,
      :node => nil
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_model[name=?]", "product[model]"

      assert_select "input#product_serial_number[name=?]", "product[serial_number]"

      assert_select "input#product_mac_address[name=?]", "product[mac_address]"

      assert_select "input#product_product_code[name=?]", "product[product_code]"

      assert_select "input#product_tension_operation[name=?]", "product[tension_operation]"

      assert_select "input#product_node_id[name=?]", "product[node_id]"
    end
  end
end
