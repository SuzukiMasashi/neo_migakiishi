class VersionExtractionService

  class << self
    def create
      new(fetch_versions_site)
    end

    private

    def fetch_versions_site
      url = "#{ENV['API_HOSTNAME']}#{ENV['API_VERSION']}"
      RestClient::Resource.new(url, verify_ssl: OpenSSL::SSL::VERIFY_NONE).get
    rescue => e
      e.response
    end
  end

  def initialize(site)
    @versions = parse(site)
  end

  def create_versions!
    @versions.sort_by {|version| version.name.to_i }.each do |version|
      next if version.name == latest_alias_name

      Version.find_or_create_by(name: version.name)
    end
  end

  def latest_version_name
    @versions
      .select {|version| version.datetime.to_s == latest_version_datetime.to_s }
      .max {|version| version.name.to_i }
      .name
  end

  private

  def parse(site)
    lines = StringIO.new(site).each_line

    lines.each.with_object([]) do |line, versions|
      next unless line.start_with?("<a ")

      link_tag, datetime, * = line.chomp.split(/\s{2,}/)

      versions <<
        OpenStruct.new.tap {|version|
          version.name     = Nokogiri.HTML(link_tag, nil, "UTF-8").text.tr("/", "")
          version.datetime = Time.parse(datetime)
        }
    end
  end

  def latest_alias_name
    ENV['API_VERSION_LATEST_DIR'].try(:tr, *["/", ""]) or raise ArgumentError
  end

  def latest_version_datetime
    @latest_version_datetime ||=
      @versions.find {|version| version.name == latest_alias_name }.datetime
  end
end
