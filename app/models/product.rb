class Product < ApplicationRecord

    acts_as_paranoid

    before_save :generate_slug
    before_update :generate_slug
    before_save :set_search_terms

    # --------------------------------------------------------------------------
    # ASSOCIATIONS
    # --------------------------------------------------------------------------

    belongs_to :user
    belongs_to :language, optional: true
    belongs_to :framework, optional: true
    belongs_to :category, optional: true
    has_many :orders

    has_many_attached :screenshots
    has_one_attached :digital_product

    # --------------------------------------------------------------------------
    # SCOPES
    # --------------------------------------------------------------------------

    scope :from_active_users, -> { joins(:user).where('users.deleted_at IS NULL AND users.github_token IS NOT NULL') }

    # --------------------------------------------------------------------------
    # VALIDATIONS
    # --------------------------------------------------------------------------


    validates :user_id, :presence => true
    validates :title, :presence => true
    validates :slug, :presence => true
    validates :description, :presence => true
    validates :github_repo_id, :presence => true
    validates :github_repo_language, :presence => true
    validates :github_repo_type, :presence => true
    validates :github_repo_name, :presence => true
    validates :price, :presence => true, numericality: { greater_than_or_equal_to: 0 }
    validates :screenshots, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

    # --------------------------------------------------------------------------
    # METHODS
    # --------------------------------------------------------------------------

    def generate_slug
        self.slug = self.title.parameterize unless self.title.nil?
    end

    # --------------------------------------------------------------------------

    def set_search_terms
       self.search_terms = [title].reject(&:blank?).join(" ")
    end

    # --------------------------------------------------------------------------

    def self.search(keywords)
        if keywords.present? && !keywords.nil?  && !keywords.empty?
            products = self.where("lower(search_terms) like ?","%#{keywords}%")
        end
        products
     end

    # --------------------------------------------------------------------------

    def total_sales()
        self.orders.sum(:net_amount)
     end



end
