class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.boolean :accepted_at
      t.boolean :declined_at

      t.timestamps
    end
  end
end
