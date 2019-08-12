# KAZOKU DB SYSTEM

## ENVIRONMENT
- Ruby version: 2.4.6
- Rails version: 5.0.7.2
- Configuration: Need to have secret.yml
- Database creation: Use sqlite3 for development environment

Run those command to run application
```
bundle install
rails db:migrate
rails db:seed
rails s
```

## Test
```
bundle exec rspec
bundle exec rspec spec/controllers/
bundle exec rspec spec/models/
bundle exec rspec spec/requests/
```

##### Try those code to recreate database based on migration files
```
bundle exec rake db:drop db:create db:migrate db:seed
```

## Deploy
You need Heroku account. Please ask maintaineer about account.

※ if you execute command below, you need to prepare for heroku

```
git push heroku release:master
```
