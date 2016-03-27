class Card < ActiveRecord::Base
  include CardClassEnumerations
  include CardSetEnumerations
  include CardTypeEnumerations
  include RaceEnumerations
  include RarityEnumerations

  belongs_to :version
end
