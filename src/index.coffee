EventEmitter = require('events').EventEmitter

class module.exports extends EventEmitter
  unauthorizedEventName: 'unauthorized'

  grantedActions: []

  grant: (action) ->
    @grantedActions.push action
    
  can: (action) ->
    action in @grantedActions
  
  require: (action)->
    (req, res, next) =>
      if @can action
        next()
      else
        if @listeners(@unauthorizedEventName).length is 0
          res.statusCode = 403
          res.end()
        else
          @emit @unauthorizedEventName, req, res, next
