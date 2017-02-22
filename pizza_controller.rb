require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative('./models/pizza.rb')

#INDEX - READ - all

get '/pizzas' do
  @pizzas = Pizza.all() #this makes the pizzas variable available in the erb file.
  erb(:index) #the route will go to index.erb and look for all pizzas
end

#NEW - CREATE to get form from the server
get '/pizzas/new' do
  erb(:new)
end

#SHOW - READ - individual pizza by id
get '/pizzas/:id' do #sinatra reads the colon and knows it's not a page to be set up but a value to be gotten - :id gets stored to a hash 'params'
  @pizza = Pizza.find( params[:id] ) #returns a new pizza object
  erb(:show)
end

#CREATE - CREATE to submit the form that has been sent by the server
post '/pizzas' do
  @pizza = Pizza.new( params )
  @pizza.save
  erb(:create)
  #redirect '/pizzas'
  #for no confimation page
  # new_order = Pizza.new( params )
  # new_order.save
  # redirect to '/pizzas/' + pizza.id.to_s
  # params[:first_name]
  # params[:last_name]
  # params[:topping]
  # params[:quantity]
end



#EDIT - UPDATE to create a form

get '/pizzas/:id/edit' do
  @pizza = Pizza.find(params[:id])
  erb(:edit)
  # pizza.save
end

#UPDATE - UPDATE to submit a form

# get '/pizzas/update' do
#   erb(:update)
# end

post '/pizzas/:id' do
  pizza = Pizza.new( params)
  pizza.update
  redirect to "/pizzas/#{pizza.id}"
end

#DESTROY - DELETE

post '/pizzas/:id/delete' do #route/action is awaiting a post request
  pizza = Pizza.find(params[:id]) #getting the params from the address bar
  @pizza = pizza.delete()
  redirect '/pizzas'
end