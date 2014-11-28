userEmail = ->
  Meteor.user().emails[0].address

Template.posts.rendered = ->
  Session.setDefault "search", ""

Template.posts.helpers
  posts: ->
    search = new RegExp(Session.get("search"))
    Posts.find({post:search}, {sort: {timestamp: -1}})
  user: -> Meteor.user()

Template.posts.events
  "click button[name=submit-post]": ()->
    post = $("input[name=post]").val()
    if post
      Posts.insert {post:post, user:userEmail(), timestamp:Date.now()}
      Template.instance().$("input[name=post]").val('')

  "input input[name=search]": ->
    Session.set "search", Template.instance().$("input[name=search]").val()

  "click button[name=clear-search]": ()->
      Template.instance().$("input[name=search]").val('')
      Session.set "search", ""
