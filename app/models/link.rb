class Link < ApplicationRecord
  validates :url, presence: true, format: URI::regexp(%w[http https])
  validates :slug, uniqueness: true, length: { within: 3..255 }

  before_validation :generate_slug

  def generate_slug
    self.slug = SecureRandom.uuid[0..5] if self.slug.blank?
  end

  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug)
  end

  def self.shorten(url, slug = '')
    link = Link.find_by(url: url, slug: slug) || Link.create(url: url, slug: slug)
    link.short if link.persisted?
  end
end
