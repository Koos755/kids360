json.array!(@parents) do |parent|
  json.extract! parent, :first_name, :last_name, :phone_number, :email, :email_confirmed, :address, :city, :state, :zip, :password_digest
  json.url parent_url(parent, format: :json)
end
