class AuthorsController < ApplicationController

  def index
    authors = Author.all
    render json: authors, 
      only: [:id, :first_name, :last_name], 
      include: { books: { only: [:title, :genre, :pages, :publisher]} }
    # render json: AuthorSerializer.new(authors, include: [:books])
  end

  def show
    author = Author.find(params[:id])
    render json: author, 
      only: [:id, :first_name, :last_name], 
      include: { books: { only: [:title, :genre, :pages, :publisher]} }
  end

  def create
    author = Author.new(author_params)

    if author.save
      render json: author, 
      only: [:id, :first_name, :last_name], 
      include: { books: { only: [:title, :genre, :pages, :publisher]} }
    else
      render json: {error: "Author not created."}  
    end 

  end

  def update
    author = Author.find(params[:id])
    author.update(author_params)

    if author.save
      render json: author, 
      only: [:id, :first_name, :last_name], 
      include: { books: { only: [:title, :genre, :pages, :publisher]} } 
    else 
      render json: {error: "Author not updated."}
    end  

  end

  def destroy
    author = Author.find(params[:id])
    author.destroy
    render json: {message: "#{author.first_name} #{author.last_name} successfully deleted."}
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end
end
