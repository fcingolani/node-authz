EventEmitter = require('events').EventEmitter

class module.exports extends EventEmitter
  unauthorizedEventName: 'unauthorized'

  grant: (user, action) ->
    user._grantedActions.push action
    
  can: (user, action) ->
    action in user._grantedActions
  
  require: (action)->
    (req, res, next) =>
      if @can req.user action
        next()
      else
        if @listeners(@unauthorizedEventName).length is 0
          res.statusCode = 403
          res.end()
        else
          @emit @unauthorizedEventName, req, res, next
