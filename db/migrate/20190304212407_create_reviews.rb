class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :description
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
