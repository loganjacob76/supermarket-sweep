require 'minitest/autorun'
require 'minitest/pride'
require './lib/product'
require './lib/shopping_cart'

class ShoppingCartTest < Minitest::Test
  def setup
    @cart = ShoppingCart.new("King Soopers", "30items")
    @product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    @product2 = Product.new(:meat, 'chicken', 4.50, '2')
    @product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    @product4 = Product.new(:produce, 'apples', 0.99, '20')
    @test_hash = {
      name: "King Soopers",
      capacity: 30
    }
  end

  def test_it_exists
    assert_instance_of ShoppingCart, @cart
  end

  def test_it_has_name
    assert_equal "King Soopers", @cart.name
  end

  def test_it_has_capacity
    assert_equal 30, @cart.capacity
  end

  def test_it_has_products
    assert_equal [], @cart.products
  end

  def test_can_add_products
    @cart.add_product(@product1)
    @cart.add_product(@product2)

    assert_equal [@product1, @product2], @cart.products
  end

  def test_return_hash_of_cart_details
    assert_equal @test_hash, @cart.details
  end

  def test_if_can_register_total_number_of_products
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)

    assert_equal 13, @cart.total_number_of_products
  end

  def test_cart_fills_when_exceeding_capacity
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)

    assert_equal false, @cart.is_full?

    @cart.add_product(@product4)

    assert_equal true, @cart.is_full?
  end

  def test_if_return_array_of_items_based_on_categories
    @cart.add_product(@product1)
    @cart.add_product(@product2)
    @cart.add_product(@product3)
    @cart.add_product(@product4)

    assert_equal [@product1, @product3], @cart.products_by_category(:paper)
    assert_equal [@product4], @cart.products_by_category(:produce)
    assert_equal [@product2], @cart.products_by_category(:meat)
  end
end
