Template.post.events
  "click a": ->
    if Template.instance().$("a").text() == "Like"
      Likes.insert post:@_id, user:Meteor.user().emails[0].address
    else
      liked = Likes.findOne(post:@_id, user:Meteor.user().emails[0].address)
      Likes.remove _id:liked?._id

  "click button": () ->
    comment = Template.instance().$("input").val()
    if comment
      Comments.insert {post:@_id, comment:comment, user:Meteor.user().emails[0].address, timestamp:Date.now()}
      Template.instance().$("input").val('')

Template.post.helpers
  likesCount: -> Likes.find(post:@_id)?.count()
  likedText:-> if Meteor.user() and Likes.findOne({post:@_id, user:Meteor.user().emails[0].address}) then "Unlike" else "Like"
  commentsCount: -> Comments.find(post:@_id)?.count()
  timeLiked: -> moment(@timestamp).fromNow()
  comments: -> Comments.find {post:@_id}
  userLoggedIn: -> Meteor.user()

Template.comment.helpers
  timeCommented: -> moment(@timestamp).fromNow()
