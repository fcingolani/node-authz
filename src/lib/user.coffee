validateObject = ( obj, values )->
  for property, value of values
    if obj[property] isnt value
      return false

  return true

module.exports =

  _authzConditions: {}

  grant: (action, condition = true)->
    @_authzConditions[action] = condition

  can: (action, obj)->
    condition = @_authzConditions[action]

    return !! switch typeof condition
      when 'function' then condition obj
      when 'object' then validateObject obj, condition
      else condition