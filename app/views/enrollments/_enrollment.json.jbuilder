json.extract! enrollment, :id, :user_id, :teacher_id, program_id, favorite, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
