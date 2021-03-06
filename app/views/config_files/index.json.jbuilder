json.array!(@config_files) do |config_file|
  json.extract! config_file, :id, :name, :checksum, :version, :content, :company_id
  json.url config_file_url(config_file, format: :json)
end
