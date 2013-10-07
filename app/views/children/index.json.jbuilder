json.array!(@children) do |child|
  json.extract! child, :parent_id, :first_name, :last_name, :email, :phone_number
  json.url child_url(child, format: :json)
end
