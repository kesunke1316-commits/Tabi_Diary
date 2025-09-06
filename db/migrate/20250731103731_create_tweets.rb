class CreateTweets < ActiveRecord::Migration[8.0]
  def change
    create_table :tweets do |t|
      t.string :Title
      t.string :Name
      t.date :Date
      t.text :Detail

      t.timestamps
    end
  end
end
