class CreateRelationships < ActiveRecord::Migration[5.2]
	def change
		create_table :relationships do |t|
			# relationshipテーブルは中間テーブルのため
			# user_idとfollow_idはt.referetionsで作成
			# foreign_key:trueは外部キーとしての設定をするためのオプション
			t.references :user, foreign_key: true
			# {to_table: :users}はfollow_idの参照先はuserテーブルにするため
			# trueだと存在しないfollowテーブルを参照してしまう
			t.references :follow, foreign_key: { to_table: :users }

			t.timestamps

			# user_idとfollow_idのペアで重複し保存させない
			t.index [:user_id, :follow_id], unique: true
		end
	end
end
