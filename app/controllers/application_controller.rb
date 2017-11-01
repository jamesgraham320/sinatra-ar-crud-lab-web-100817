require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  set :method_override, 'true'


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    redirect '/posts'
  end

  get '/posts' do
    erb :posts
  end

  get '/posts/new' do
    erb :new
  end
  
  get "/posts/:id" do
    @post = Post.find(params[:id])
    erb :show
  end

  get "/posts/:id/edit" do
    @post = Post.find(params[:id])
    erb :edit
  end
  
  post '/posts' do
    @post = Post.create(params)
    #@post = Post.create(name: params[:name], content: params[:content])
    erb :posts
  end
  
  get '/index' do 
    erb :index
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(
      name: params[:name],
      content: params[:content])
    redirect "/posts/#{@post.id}"
  end

  delete "/posts/:id/delete" do
    post = Post.find(params[:id])
    @post_name = post.name
    post.destroy
    erb :delete
  end
end
