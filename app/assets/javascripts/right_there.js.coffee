window.RightThere =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Pages: {}
  initialize: ->
    new window.RightThere.Pages.MainPage()

$(document).ready ->
  RightThere.initialize()
