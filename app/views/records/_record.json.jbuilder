json.extract! record, :id, :title, :year, :artist_id, :user_id, :created_at, :updated_at
json.url record_url(record, format: :json)
