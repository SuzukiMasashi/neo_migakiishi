json.array!(@versions) do |version|
  json.extract! version, :id, :name
  json.url version_url(version, format: :json)
end
