class AddLanguageToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :language, foreign_key: true
  end
end
