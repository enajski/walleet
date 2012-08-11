class Routers.Walleet extends Backbone.Router
  routes: {
    "": "mainPage"
    "welcome": "welcome"
    "goodbye": "goodbye"
    "groups/:id": "groupShow"
    "person/sign_in": "signIn"
    "person/sign_up": "signUp"
    "person/reset_password/:token": "resetPassword"
    "*anything": "notFound"
  }

  welcome: =>
    this.setLayout(Views.MainLayout)
    @layout.addSubview("content", Views.Welcome).render()

  goodbye: =>
    this.setLayout(Views.MainLayout)
    @layout.addSubview("content", Views.Goodbye).render()

  mainPage: =>
    if !App.auth.loggedIn()
      App.nav.navigate("welcome")
    else
      this.setLayout(Views.MainLayout)
      @layout.addSubview("content", Views.FeedView)

  groupShow: (groupId) =>
    @group = new Models.Group({id: groupId})
    this.setLayout(Views.MainLayout, {currentGroup: @group})

    @layout.addSubview("content", Views.GroupView, {group: @group})
    App.l = @layout

    @group.fetch()

  signIn: =>
    this.setLayout(Views.MainLayout)
    @layout.addSubview("content", Views.Login).render()

  signUp: =>
    this.setLayout(Views.MainLayout)
    @layout.addSubview("content", Views.Signup).render()

  notFound: (path) =>
    this.setLayout(Views.MainLayout)
    @layout.addSubview("content", Views.NotFoundView, {path: path}).render()

  resetPassword: (token) =>
    this.setLayout(Views.MainLayout)
    @layout.addSubview("content", Views.ResetPassword, {token: token}).render()

  setLayout: (klass, options) =>
    @layout = new klass(options)
    @layout.render()
