class Order < ApplicationRecord

    acts_as_paranoid

    # --------------------------------------------------------------------------
    # ASSOCIATIONS
    # --------------------------------------------------------------------------

    belongs_to :product
    belongs_to :user
    has_one_attached :digital_product

    # --------------------------------------------------------------------------
    # VALIDATIONS
    # --------------------------------------------------------------------------

    validates :product_id, :presence => true
    validates :product_name, :presence => true
    validates :user_id, :presence => true
    validates :author_id, :presence => true
    validates :amount, :presence => true, numericality: { greater_than: 0 }
    validates :net_amount, :presence => true, numericality: { greater_than: 0 }
    validates :fees_amount, :presence => true, numericality: { greater_than: 0 }
    validates :fee_percentage, :presence => true, numericality: { greater_than: 0 }
    validates :stripe_response_data, :presence => true
    validates :digital_product, :presence => true

    # --------------------------------------------------------------------------
    # METHODS
    # --------------------------------------------------------------------------

    def seller
        User.find(self.author_id) unless self.author_id.nil?
    end

end
