class CardsExtractionService

  class << self
    def create(import_job)
      version = import_job.version

      new(version, fetch_cards_json(version.name))
    end

    private

    def fetch_cards_json(version_name)
      url = "#{ENV['API_HOSTNAME']}#{ENV['API_VERSION']}#{version_name}/#{ENV['API_LANGUAGE']}#{ENV['CARDS_COLLECTIBLE_JSON']}"
      RestClient::Resource.new(url, verify_ssl: OpenSSL::SSL::VERIFY_NONE).get
    rescue => e
      e.response
    end
  end

  def initialize(version, json)
    @version = version
    @cards   = JSON.load(json)
  end

  def create_cards!
    ActiveRecord::Base.transaction do
      version_id = @version.id

      Card.delete_all(version_id: version_id)

      @cards.each do |card|
        Card.find_or_create_by(
          version_id:  version_id,
          code:        card['id'],
          cost:        card['cost'],
          name:        card['name'],
          card_class:  card['playerClass'] || 'NEUTRAL',
          card_set:    card['set'],
          card_type:   card['type'],
          race:        card['race'],
          rarity:      card['rarity'],
          collectible: card['collectible'],
          card_text:   card['text'],
          attack:      card['attack'],
          health:      card['health'],
          durability:  card['durability'],
        )
      end
    end
  end
end
