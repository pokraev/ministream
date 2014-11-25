Template.post.events
  "click a": ->
    Likes.insert post:@_id, user:Meteor.user().emails[0].address

  "click button": () ->
    comment = Template.instance().$("input").val()
    if comment
      Comments.insert {post:@_id, comment:comment, user:Meteor.user().emails[0].address, timestamp:Date.now()}
      Template.instance().$("input").val('')

Template.post.helpers
  likesCount: -> Likes.find(post:@_id)?.count()
  notLiked:-> if Meteor.user() then !Likes.findOne({post:@_id, user:Meteor.user().emails[0].address})
  commentsCount: -> Comments.find(post:@_id)?.count()
  timeLiked: -> moment(@timestamp).fromNow()
  comments: -> Comments.find {post:@_id}
  userLoggedIn: -> Meteor.user()

Template.comment.helpers
  timeCommented: -> moment(@timestamp).fromNow()
