User = require './user'

module.exports = (init)->
  (req, res, next)->
    if req.user?
      req.user extends User
      init req.user

    next()