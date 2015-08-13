# Homepage (Root path)
helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:seller_id]) if session[:seller_id]
  end
end

get '/' do
  erb :index
end

get '/products/new' do
  erb :'/products/new'
end

get '/sellers/new' do
  erb :'/sellers/new'
end

get '/products/:id' do
  erb :'/products/show'
end

get '/sellers/:id' do
  @seller = Seller.find params[:id]
#  image = @seller.image.new()
#  image.file = params[:image]
#  image.save
  erb :'/sellers/show'
end

get '/sellers' do
  @seller = Seller.all
  erb :'/sellers/index'
end

get '/sellers/:id' do
 @seller= Seller.find(params[:id])
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
    seller_id: params[:seller_id],
    buyer_id: params[:buyer_id],
    image: params[:image],
    category: params[:category],
    price: params[:price]
    )    
  if @product.save
    redirect '/product/:id'
  else
    erb:'/product/new'
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

  @filename = params[:file][:filename]
  file = params[:file][:tempfile]
  
  @extension= @filename.match(/(\.(?i)(jpg|png|gif|bmp|jpeg))\z/).to_s

    

  File.open("./public/images/sellers/#{@seller.id}_seller#{@extension}", 'wb') do |f|
    f.write(file.read)
  end

  @image = Image.create(
    file_path: "/images/sellers/#{@seller.id}_seller#{@extension}", 
    seller_id: @seller.id
    )
  binding.pry
  
  if @seller.save
    redirect '/sellers'
  else
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

post '/sellers/show' do
 erb :'/sellers/show'
end
