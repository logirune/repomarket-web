class Language < ApplicationRecord

    before_save :generate_slug
    before_update :generate_slug

    # --------------------------------------------------------------------------
    # ASSOCIATIONS
    # --------------------------------------------------------------------------

    has_many :products, dependent: :nullify
    has_many :frameworks, dependent: :nullify

    # --------------------------------------------------------------------------
    # VALIDATIONS
    # --------------------------------------------------------------------------

    validates :name, presence: true, uniqueness: true

    # --------------------------------------------------------------------------
    # METHODS
    # --------------------------------------------------------------------------

    # Save or create a programming language

    def self.add_language(programming_language = 'Other')
        language = where(name: programming_language, slug: programming_language.parameterize ).first_or_create!
        language.update(name: programming_language , slug: programming_language.parameterize)
        language
    end

    # --------------------------------------------------------------------------

    # Generate a slug as a Url parameter
    # Note : explore_url(language: 'ruby', framework: 'ruby-on-rails', category: 'all')
    # Note : /language/ruby/framework/ruby-on-rails/category/all

    def generate_slug
        self.slug = self.name.parameterize unless self.name.nil?
    end


end
