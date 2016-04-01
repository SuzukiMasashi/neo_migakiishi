class Version < ActiveRecord::Base
  has_many :cards,                                       dependent: :delete_all
  has_many :import_jobs, class_name: "Cards::ImportJob", dependent: :delete_all
end
