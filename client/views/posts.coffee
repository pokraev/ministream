Template.posts.helpers
  posts: -> Posts.find({}, {sort: {timestamp: -1}})
  user: -> Meteor.user()

Template.posts.events
  "click button[name=submit-post]": ()->
    post = $("input[name=post]").val()
    if post
      Posts.insert {post:post, user:Meteor.user().emails[0].address, timestamp:Date.now()}
      Template.instance().$("input").val('')
