@Posts = new Meteor.Collection "posts"
@Likes = new Meteor.Collection "likes"
@Comments = new Meteor.Collection "comments"

Likes.allow
  remove: -> true
  insert: -> true
