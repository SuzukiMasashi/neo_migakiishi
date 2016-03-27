json.array!(@cards_import_jobs) do |cards_import_job|
  json.extract! cards_import_job, :id, :version_id, :status
  json.url cards_import_job_url(cards_import_job, format: :json)
end
