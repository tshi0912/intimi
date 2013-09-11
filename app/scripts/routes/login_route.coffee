Intimi.LoginRoute = Ember.Route.extend
  actions:
    login: ->
      loginController = @controllerFor('login')
      username = loginController.get('username')
      password = loginController.get('password')

      @get('store').find('user', name: username).then (users) =>
        return Notifier.error('您输入的用户名不存在') if Ember.isEmpty(users)

        user = users.get('firstObject')
        return Notifier.error('您输入的密码不正确') if user.get('password') != password

        applicationController = @controllerFor('application')
        transition = applicationController.get('savedTransition')

        Intimi.Auth.set('user', user)
        applicationController.login()

        # if the user was going somewhere, send them along, otherwise
        # default to `/home`
        if transition && transition.get('targetName') != 'authenticated.index'
          transition.retry()
        else
          @transitionTo('home')