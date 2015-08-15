get '/' do
  @products = Product.order(:created_at)
  erb :index
end

get '/products' do
  @products = Product.order(:created_at) 
  # .take(6)
  erb :'products/index'
end

get '/sellers/profile' do
  erb :'/sellers/seller-profile'
end


get '/products/new' do
  @sellers = Seller.all
  erb :'/products/new'
end

get '/sellers/new' do
  erb :'/sellers/new'
end

get '/products/:id' do
  @product = Product.find params[:id]
  erb :'/products/show'
end

get '/sellers/:id' do
  @seller = Seller.find params[:id]
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

get '/image' do
  
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
  seller = Seller.find params[:id]
  seller.destroy
  redirect to '/sellers'
end

delete '/products/:id' do
  product = Product.find params[:id]
  product.destroy
  redirect to '/products'
end

post '/sellers/show' do
 erb :'/sellers/show'
end
