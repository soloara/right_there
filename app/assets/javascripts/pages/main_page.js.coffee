window.RightThere.Pages.MainPage = Backbone.Marionette.Controller.extend
    
  initialize: ->
    @places = new window.RightThere.Collections.Places()
    @initializeTemplates()
    @buildModules()
    @loadData()


  initializeTemplates: ->
    @header = new window.RightThere.Views.LayoutsHeader()
    @map = new window.RightThere.Views.Map(collection: @places)
    # this.footer = new window.RightThere.Views.LayoutsFooter()
    
  buildModules: ->
    $('#header').replaceWith(@header.$el)
    $('#map').replaceWith(@map.$el)
    
  render: ->
    @header.render()
    @map.render()
    return this
  
  loadData: ->
    @places.fetch
      success: =>
        @render()