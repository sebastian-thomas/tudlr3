class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.integer :jtype
      t.text :desc
      t.integer :coins
      t.datetime :expiry
      t.datetime :jtime
      t.integer :user_id
      t.integer :grade
      t.integer :status
      t.string :category
      t.integer :completedby

      t.timestamps
    end
  end
end
