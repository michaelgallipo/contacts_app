class Api::ContactsController < ApplicationController


  def index
    @contacts = Contact.all 

    if params[:search]
      @contacts = Contact.where("first_name LIKE ? OR last_name LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    render "index.json.jbuilder"
  end

  def show
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    render "show.json.jbuilder"
  end

  def create
  @contact = Contact.create(
    first_name: params[:first_name],
    middle_name: params[:middle_name],
    last_name: params[:last_name],
    city: params[:city],
    email: params[:email],
    cell_phone: params[:cell_phone],
    bio: params[:bio])
  render "show.json.jbuilder"
  end

  def update
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.city = params[:city] || @contact.city
    @contact.email = params[:email] || @contact.email
    @contact.cell_phone = params[:cell_phone] || @contact.cell_phone
    @contact.bio = params[:bio] || @contact.bio
    @contact.save

    render "show.json.jbuilder"

  end

  def destroy
    contact_id = params[:id]
    @contact = Contact.find_by(id: contact_id)
    @contact.destroy

    render json: {message: "Contact successfully deleted"}
  end

end
