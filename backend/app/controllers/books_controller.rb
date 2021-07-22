class BooksController < ApplicationController

  def index
    books = Book.all
    render json: books,
      except: [:created_at, :updated_at], 
      include: { author: { only: [:first_name, :last_name] } }
  end

  def show
    book = Book.find(params[:id])
    render json: book,
    except: [:created_at, :updated_at], 
    include: { author: { only: [:first_name, :last_name] } }
  end

  private

  def book_params
    params.require(:book).permit(:title, :publisher, :genre, :pages, :author_id)
  end
  
end
