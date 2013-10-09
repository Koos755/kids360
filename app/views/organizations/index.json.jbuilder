json.array!(@organizations) do |organization|
  json.extract! organization, "name"
end
