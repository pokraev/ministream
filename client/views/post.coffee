Template.post.events
  "click a[name=btn-like]": () ->
    user = Meteor.user().emails[0].address
    Likes.insert post:@_id, user:user

  "click button[name=btn-submit-comment]": ()->
    user = Meteor.user().emails[0].address
    comment = $("input[name=input-comment-#{@_id}]").val()
    Comments.insert {post:@_id, comment:comment, user:user, timestamp:Date.now()}
    $("input[name=input-comment-#{@_id}]").val('')

Template.post.helpers
  likesCount: -> Likes.find(post:@_id)?.count()
  notLiked:-> if Meteor.user() then !Likes.findOne({post:@_id, user:Meteor.user().emails[0].address})
  commentsCount: -> Comments.find(post:@_id)?.count()
  timeLiked: -> moment(@timestamp).fromNow()
  comments: -> Comments.find {post:@_id}
  userLoggedIn: -> Meteor.user()

Template.comment.helpers
  timeCommented: -> moment(@timestamp).fromNow()
