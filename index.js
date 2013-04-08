// Generated by CoffeeScript 1.4.0
(function() {
  var EventEmitter,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  EventEmitter = require('events').EventEmitter;

  module.exports = (function(_super) {

    __extends(exports, _super);

    function exports() {
      return exports.__super__.constructor.apply(this, arguments);
    }

    exports.prototype.unauthorizedEventName = 'unauthorized';

    exports.prototype.grant = function(user, action) {
      return user._grantedActions.push(action);
    };

    exports.prototype.can = function(user, action) {
      return __indexOf.call(user._grantedActions, action) >= 0;
    };

    exports.prototype.require = function(action) {
      var _this = this;
      return function(req, res, next) {
        if ((req.user != null) && _this.can(req.user(action))) {
          return next();
        } else {
          if (_this.listeners(_this.unauthorizedEventName).length === 0) {
            res.statusCode = 403;
            return res.end();
          } else {
            return _this.emit(_this.unauthorizedEventName, req, res, next);
          }
        }
      };
    };

    return exports;

  })(EventEmitter);

}).call(this);
