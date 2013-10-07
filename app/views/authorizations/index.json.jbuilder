json.array!(@authorizations) do |authorization|
  json.extract! authorization, :organization_id, :child_id
  json.url authorization_url(authorization, format: :json)
end
