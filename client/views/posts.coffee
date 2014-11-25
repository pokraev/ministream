Template.posts.rendered = ->
  Session.set("show-comments", false)

Template.posts.helpers
  posts: -> Posts.find({}, {sort: {timestamp: -1}})
  user: -> Meteor.user()

Template.posts.events
  "click button[name='btn-submit-post']": ->
    Posts.insert
      post:$('input[name=input-post]').val()
      user:Meteor.user().emails[0].address
      timestamp:Date.now()
