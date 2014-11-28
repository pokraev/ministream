userEmail = -> Meteor.user().emails[0].address

Template.post.events
  "click a[name='btnLike']": ->
    if Template.instance().$("a").text() == "Like"
      Likes.insert post:@_id, user:userEmail
    else
      liked = Likes.findOne(post:@_id, user:userEmail)
      Likes.remove _id:liked?._id

  "click a[name='btnRemove']": ->
    post = Posts.findOne(post:@_id)
    Posts.remove _id:post?._id
    #ToDo remove Comments and Likes

  "click button": () ->
    comment = Template.instance().$("input").val()
    if comment
      Comments.insert {post:@_id, comment:comment, user:userEmail, timestamp:Date.now()}
      Template.instance().$("input").val('')

Template.post.helpers
  likesCount: -> Likes.find(post:@_id)?.count()
  likedText:-> if Meteor.user() and Likes.findOne({post:@_id, user:userEmail}) then "Unlike" else "Like"
  commentsCount: -> Comments.find(post:@_id)?.count()
  date: -> new Date(@timestamp)
  comments: -> Comments.find {post:@_id}
  userLoggedIn: -> Meteor.user()
  ownPost: -> userEmail() == @user

Template.comment.events
  "click a[name='btnRemoveComment']": ->
    comment = Comments.findOne(_id:@_id)
    Comments.remove _id:comment?._id

Template.comment.helpers
  date: -> new Date(@timestamp)
  ownComment: -> userEmail() == @user
