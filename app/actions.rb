# Homepage (Root path)
get '/' do
  erb :index
end

get '/products/new' do
  erb :'products/new'
end

get '/sellers/new' do
  erb :'sellers/new'
end

get '/sellers/:id' do
 # @seller= Seller.find(params:[id])
 erb :'sellers/show'
end

post '/products/new' do
end

post '/sellers/new' do
  @seller = Seller.create(
    name: params[:name],
    location: params[:location],
    story: params[:story],
    blurb: params[:blurb],
    specialty: params[:specialty],
    video: params[:video]
    )
  redirect '/sellers/:id'
end


