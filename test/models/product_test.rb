require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
 test "product attribute must not be empty" do 
 		product = Product.new
 		assert product.invalid?
 		assert product.errors[:title].any?
 		assert product.errors[:description].any?
 		assert product.errors[:image_url].any?
 		assert product.errors[:price].any?
 end
 test "price should always be postive" do
 		product = Product.new( title: "Ruby",
 											description: "Awseome Book",
 											image_url: "cs.jpg"
 											)
 		product.price = -1
 		assert product.invalid?
 		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

 		product = Product.new( title: "Rails",
 											description: "Its made on ruby",
 											image_url: "pk.gif"
 										)
 		product.price = 0
 		assert product.invalid?
 		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
 		product = Product.new(title: "Github",
 										description: "Good to store Projects",
 										image_url: "ping.png"
 									)
 		product.price = 2
 		assert product.valid?
 end

 def new_product(image_url)
 		Product.new(title: "Mark",
 					description: "Famous Celebrity",
 					price: 9.0,
 					image_url: image_url
 			)
 end
	test "image_url" do
		ok = %w{kmp.gif ri.png la.jpg max.png KMP.gif}
		bad = %w{ac.pig kmp.gif/abc ri.pdf}
		ok.each do |url|
			assert new_product(url).valid?
		end
		bad.each do |url|
			assert new_product(url).invalid?
		end
	end

	test "unique title" do
		Product.create(title: "Rishav", description: "Nice Book",
			image_url: "or.gif",
			price: 9
		)
		
		product = Product.new(title: "Rishav", description: "Must Read",
									image_url: "body.jpg",
									price: 10
								)
		# binding.pry
		assert product.invalid?
	end
	test "unique title using fixtures" do
		product= Product.new(title: products(:ruby).title,
			description: "Cool",
			image_url: "pink.gif",
			price: 23
		)
		assert product.invalid?
		assert_equal ["has already been taken"], product.errors[:title]
	end
end
