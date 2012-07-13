class Walleet.Models.Group extends Backbone.Model
  url: ->
    "/api/v1/groups/" + this.get("id") + ".json"


class Walleet.Collections.GroupCollection extends Backbone.Collection
  model: Walleet.Models.Group
  url: "/api/v1/groups"

  comparator: (group) -> group.get('name')
