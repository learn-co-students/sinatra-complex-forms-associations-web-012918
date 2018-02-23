class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  #create a new pet with owner
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])

    if !params[:owner][:name].empty?
      @owner = Owner.create(name:params[:owner][:name])
      @pet.owner_id = @owner.id
      @owner.save
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner = @owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
