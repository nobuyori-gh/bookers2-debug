class Relationship < ApplicationRecord
	# UserモデルをFollowing,Followerモデルと呼ぶ
	belongs_to :following, class_name:"User"
	belongs_to :follower, class_name: "User"
end