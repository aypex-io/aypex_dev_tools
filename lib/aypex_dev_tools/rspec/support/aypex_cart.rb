def update_cart
  page.execute_script("$('form#update-cart').submit()")
end

def cart_container
  find_all("#cart-detail .shopping-cart-item").first
end

def add_to_cart(product)
  visit aypex.product_path(product)

  expect(page).to have_selector("form#add-to-cart-form")
  expect(page).to have_selector(:button, id: "add-to-cart-button", disabled: false)

  yield if block_given?

  click_button "add-to-cart-button"

  expect(page).to have_content(Aypex.t(:added_to_cart))
  visit aypex.cart_path
end
