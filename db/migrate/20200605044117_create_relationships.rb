class CreateRelationships < ActiveRecord::Migration[5.2]
	def change
		create_table :relationships do |t|
			# relationshipテーブルは中間テーブルのため
			t.integer :following_id
			t.integer :follower_id

			t.timestamps
		end
	end
end
