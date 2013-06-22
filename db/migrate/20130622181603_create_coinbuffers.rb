class CreateCoinbuffers < ActiveRecord::Migration
  def change
    create_table :coinbuffers do |t|
      t.integer :user_id
      t.integer :job_id
      t.integer :coins

      t.timestamps
    end
  end
end
