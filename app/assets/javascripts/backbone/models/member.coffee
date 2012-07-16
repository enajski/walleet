class Models.Member extends Backbone.Model
  url: ->
    "/api/v1/groups/" + this.get("group").get("id") + ".json"

  sync: (method, model, options) =>
    if (method == "create")
      options.url = "/api/v1/groups/" + this.get("group").get("id") + "/add_person.json"
    Backbone.sync(method, model, options)

  toJSON: =>
    id: this.get("group").get("id")
    person: this.get("person")
