json.array!(@cards) do |card|
  json.extract! card, :id, :code, :cost, :name, :card_class, :card_set, :card_type, :race, :rarity, :collectible, :card_text, :attack, :health, :durability
  json.url card_url(card, format: :json)
end
