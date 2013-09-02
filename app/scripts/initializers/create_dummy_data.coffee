Ember.onLoad 'Ember.Application', (Application) ->
  Application.initializer
    name: 'createDummyData'
    initialize: (container, application) ->
      store = container.lookup('store:main')

      store.find('user', name: 'intimi').then (users) ->
        return unless Ember.isEmpty(users)

        user = store.createRecord Intimi.User,
                 email: 'intimi@example.com'
                 name: 'intimi'
                 password: '123456'
                 realname: 'Intimi'
                 roles: 'admin'
        user.save()

      store.find(Intimi.PrepaidCard).then (cards) ->
        return unless Ember.isEmpty(cards)

        for price in [10, 50, 100, 300, 500, 1000]
          card = store.createRecord(Intimi.PrepaidCard, price: price)
          card.save()
