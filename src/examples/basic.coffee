http = require 'http'
connect = require 'connect'

authz = require '../index'

app = connect()


app.use (req, res, next)->
  req.user =
    id: 1
    name: "John"

  next()

app.use authz (user)->
  user.grant 'article.read'

  user.grant 'article.edit',
    authorId: user.id

  user.grant 'article.delete', (article)->
    article.authorId is user.id and article.title is ''

app.use (req, res)->

  ownArticle =
    title: "Caterpillar Express"
    authorId: 1

  othersArticle =
    title: "Blue Note"
    authorId: 2

  emptyArticle =
    title: ""
    authorId: 1

  tests =

    "can read others articles?":
      req.user.can 'article.read', othersArticle

    "can edit own articles?":
      req.user.can 'article.edit', ownArticle

    "can edit others articles?":
      req.user.can 'article.edit', othersArticle

    "can delete titled articles?":
      req.user.can 'article.delete', ownArticle

    "can delete untitled articles?":
      req.user.can 'article.delete', emptyArticle

  res.write "#{test} #{value}\n" for test, value of tests
  res.end()

http
  .createServer(app)
  .listen(3000)