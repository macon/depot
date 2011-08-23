require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  # Replace this with your real tests.
  test "empty product is invalid" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "duplicate title is invalid" do
    product = new_product {|p| p.title = products(:ruby).title}
    assert !product.save
    assert_not_nil (product.errors[:title] * ";").index("has already been taken")
  end

  test "correct price is valid" do
    product = new_product

    [0.01, 1, 100.00].each do |v|
      product.price = v
      assert product.valid?
    end
  end

  test "invalid price fails validation" do
    product = new_product

    [-1, 0, 0.001].each do |v|
      product.price = v
      assert product.invalid?
      assert_match(/0\.01/, product.errors[:price].join('; '))
    end
  end

  test "correct image_url is valid" do
    image_urls = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    image_urls.each { |url| assert new_product_with_image(url).valid?, "#{url} should be valid" }
  end

  test "incorrect image_url fails validation" do
    image_urls = %w{ fred.doc fred.gif/more fred.png.more fred }
    image_urls.each { |url| assert new_product_with_image(url).invalid?, "#{url} should be invalid" }
  end

  private
  def new_product_with_image(image_url)
    new_product {|p| p.image_url = image_url}
  end

  def new_product
    product = Product.new(:title => "My Book title",
                :description => "yyy",
                :price => 1,
                :image_url => "ruby.jpg")
    yield product if block_given?
    product
  end
end
