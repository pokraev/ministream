Meteor.publish "posts", -> Posts.find()
Meteor.publish "likes", -> Likes.find()
Meteor.publish "comments", -> Comments.find()
