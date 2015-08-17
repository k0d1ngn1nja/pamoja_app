helpers do
  def current_buyer
    if session[:admin] == false && Buyer.first
      @buyer = Buyer.first
    end
  end

  def create_cart
    if current_buyer 
      @cart = Cart.create(buyer_id: current_buyer.id) 
    end
  end

  def current_cart
    Cart.first
  end 
end

get '/' do
  @products = Product.order(:created_at)
  @seller = Seller.all
  erb :index
end

get '/products' do
  @products = Product.order(:created_at) 
  erb :'products/index'
end

get '/sellers/profile/:id' do
  @seller = Seller.find(params[:id])
  erb :'/sellers/seller-profile'
end

get '/products/new' do
  if current_buyer
    redirect "/"
  else
    @sellers = Seller.all
    erb :'/products/new'
  end
end

get '/sellers/new' do
  if current_buyer
    redirect "/"
  else
    erb :'/sellers/new'
  end
end

get '/products/:id' do
  @product = Product.find params[:id]
  @seller = @product.seller
  erb :'/products/show'
end

get '/sellers/:id' do
  @seller = Seller.find params[:id]
  @product = @seller.products
  erb :'/sellers/show'
end

get '/sellers' do
  @seller = Seller.all
  erb :'/sellers/index'
end

get '/products' do
  @product = Product.all
  erb :'/products/index'

end

get '/sellers/:id' do
 @seller= Seller.find(params[:id])
 @images= Image.all
 erb :'sellers/show'
end

get '/sellers/:id/edit' do
  @seller = Seller.find(params[:id])
  erb :'/sellers/edit'
end

post '/products/new' do
  @product = Product.create(
    name: params[:name],
    description: params[:description],
    category: params[:category],
    price: params[:price].to_i,
    seller_id: params[:seller_id].to_i
   )    

  if params[:file] && @product.persisted?
    @filename = params[:file][:filename]
    file = params[:file][:tempfile]
    @extension= @filename.match(/(\.(?i)(jpg|png|gif|bmp|jpeg))\z/).to_s

    File.open("./public/images/products/#{@product.id}_product#{@extension}", 'wb') do |f|
     f.write(file.read)
    end
    
    @image = Image.create( 
      product_id: @product.id,
      file_path:"/images/products/#{@product.id}_product#{@extension}"
     )
    if @image.save && @product.save 
      redirect '/products'
    end
  else 
    @no_file_error = "You must add a photo to proceed"
    erb:'/products/new'
  end
end

post '/sellers/new' do
  @seller = Seller.create(
    name: params[:name],
    location: params[:location],
    story: params[:story],
    blurb: params[:blurb],
    specialty: params[:specialty],
    video: params[:video],
  )
  if params[:file] && @seller.persisted?
    @filename = params[:file][:filename]
    file = params[:file][:tempfile]
    
    @extension= @filename.match(/(\.(?i)(jpg|png|gif|bmp|jpeg))\z/).to_s

    File.open("./public/images/sellers/#{@seller.id}_seller#{@extension}", 'wb') do |f|
      f.write(file.read)
    end

    @seller.update(image: "/images/sellers/#{@seller.id}_seller#{@extension}")
    @seller.save
    redirect '/sellers'
  else 
    @no_file_error = "You must add a photo to proceed"
    erb :'/sellers/new'
  end
end


put '/sellers/:id/edit' do
  @seller = Seller.find(params[:id])
  if @seller.update_attributes(name: params[:name], location: params[:location])
    redirect '/sellers'
  else
    erb :'sellers/edit'
  end
end

delete '/sellers/:id' do
  unless current_buyer
    seller = Seller.find params[:id]
    seller.destroy
  end
    redirect to '/sellers'
end

delete '/products/:id' do
  unless current_buyer
    product = Product.find params[:id]
    product.destroy
  end
    redirect to '/products'
end

post '/sellers/show' do
 erb :'/sellers/show'
end

get '/cart' do
  @cart = current_cart
  erb :'/cart/index'
end

get '/cart/add/:item_id' do

end

# post '/cart/add/:item_id' do

# end

# post '/cart/:id/item/:itemId/qunaity/:qty' do

# end

post '/cart/item/add' do
  @item = Item.create(product_id: params[:product_id], cart_id: current_cart.id, quantity: 1)
  redirect to "/cart"
end

delete '/cart' do
    item = Item.find params[:item_id]
    # product_id = current_cart.items.each do |product|
    #   product.id
    item.destroy
    redirect to '/cart'
end

post '/cart/checkout' do
  erb :'cart/checkout'
end

#these are forced sessions!
get '/admin/login' do
  session[:admin] = true
  redirect '/'
end


get '/admin/logout' do
  session[:admin] = false
  if current_cart.nil?
    create_cart
  end
  redirect '/'
end

post '/charge' do
  # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
  )

  erb :charge
end
