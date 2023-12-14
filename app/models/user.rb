class User < ApplicationRecord
   has_many :enrollments
   has_many :teachers,  -> { where(enrollments: {favorite: true})},  through: :enrollments
   scope :classmates,  ->(user) { where('id !=? AND kind =?', user.id, 0)  }
end
