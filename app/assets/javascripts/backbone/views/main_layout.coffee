class Layouts.Main extends Layout
  template: JST["backbone/templates/layouts/main"]

  el: "#body"

  events:
    "click #sign-out": "signOut"

  initialize: (options) =>
    options ||= {}
    @currentGroup = options.currentGroup

  render: =>
    super()
    context = this.context()
    this.$el.html(this.template(context))
    if Auth.loggedIn()
      groupList = new Views.GroupListView(el: this.container("group-list"), currentGroup: @currentGroup)
      groupList.render()
      createGroup = new Views.GroupFormView(el: this.container("group-form"))
      createGroup.render()

  signOut: (ev) =>
    ev.preventDefault()
    Auth.logout()
    Router.navigate("goodbye", {trigger: true})
    alert = new Views.AlertView(el: this.alertContainer())
    alert.addNotice("You are signed out")
    alert.render()

  context: =>
    currentPerson: Auth.person.toJSON().person
    loggedIn: Auth.loggedIn()
    groups: _.map(App.groups.toJSON(), (group) =>
      group.url = "#groups/" + group.id
      group)

  alertContainer: =>
    container = $(".alert-container", this.$el)
    if container.length == 0
      container = $(".alert-container")
    container
