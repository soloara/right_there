window.RightThere.Collections.Places = Backbone.Collection.extend
  model: window.RightThere.Models.Place
  
  url: '/api/v1/places'
  
  provinces: ->
    @where level: 'province'
    
  cities: (provience)->
    @children('city', provience)
    
  districts: (city)->
    @children('district', city)
    
  children: (level, parent)->
    if parent
      levels = { city: 10000, district: 100 }
      scope = levels[level]
      return @filter (child)=>
        childId = child.get('id')
        parentId = parseInt(childId / scope) * scope
        parentId == parent.id && child.get('level') == level
    else
      return @where level: level