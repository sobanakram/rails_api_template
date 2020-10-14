# Rails API Template

[![CircleCI](https://circleci.com/gh/sobanakram/rails_api_template.svg?style=svg)](https://circleci.com/gh/sobanakram/rails_api_template)
<!-- [![Code Climate](https://codeclimate.com/github/rootstrap/rails_api_base/badges/gpa.svg)](https://codeclimate.com/github/rootstrap/rails_api_base) -->
<!-- [![Test Coverage](https://api.codeclimate.com/v1/badges/63de7f82c79f5fe82f46/test_coverage)](https://codeclimate.com/github/rootstrap/rails_api_base/test_coverage) -->

Rails Api Template is a boilerplate project for JSON RESTful APIs. It follows the community best practices in terms of standards, security and maintainability, integrating a variety of testing and code quality tools. It's based on Rails 6 and Ruby 2.7.2.

Finally, it contains a plug an play Administration console (thanks to [ActiveAdmin](https://github.com/activeadmin/activeadmin)).

## Features

This template comes with:

- Schema
  - Users table
  - Admin users table
- Endpoints
  - Sign up with user credentials
  - Sign in with user credentials
  - Sign out
  - Reset password
  - Get and update user profile
- Administration panel for users
- Rspec tests
- Code quality tools
- API documentation following https://apiblueprint.org/

## How to use

1. Clone this repo
2. Install PostgreSQL in case you don't have it
3.   Run bootstrap.sh with the name of your your project like `./bootstrap.sh my_awesome_project`
3. Create your `database.yml` and `application.yml` file
4. `bundle install`
5. Generate a secret key with `rake secret` and paste this value into the `application.yml`.
6. `rake db:create`
7. `rake db:migrate`
8. `rspec` and make sure all tests pass
9. `rails s`
10. You can now try your REST services!

## Gems

- [ActiveAdmin](https://github.com/activeadmin/activeadmin) for easy administration
- [ActiveModelSerializer](https://github.com/rails-api/active_model_serializers) for easy administration
- [Annotate](https://github.com/ctran/annotate_models) for doc the schema in the classes
- [ApiPie](https://github.com/Apipie/apipie-rails) for Api documentation
- [Better Errors](https://github.com/charliesome/better_errors) for a better error page
- [Brakeman](https://github.com/presidentbeef/brakeman) for static analysis security
- [Bullet](https://github.com/flyerhzm/bullet) help to kill N+1
- [Byebug](https://github.com/deivid-rodriguez/byebug) for debugging
- [Capistrano](https://github.com/capistrano/rails) for deployment
- [Capistrano::Rails::Console](https://gitlab.com/ydkn/capistrano-rails-console) for rails console from server
- [Devise](https://github.com/plataformatec/devise) for basic auth
- [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth) for api auth
- [Factory Bot](https://github.com/thoughtbot/factory_bot) for testing data
- [Faker](https://github.com/stympy/faker) for generating test data
- [Figaro](https://github.com/laserlemon/figaro) for handling environment variables
- [Letter Opener](https://github.com/ryanb/letter_opener) for previewing a mail in the browser
- [Oj](https://github.com/ohler55/oj) for optimized json
- [Puma](https://github.com/puma/puma) for the server
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices) for rails linting
- [Reek](https://github.com/troessner/reek) for ruby linting
- [RSpec](https://github.com/rspec/rspec) for testing
- [Rubocop](https://github.com/bbatsov/rubocop/) for ruby linting
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) adds other testing matchers
- [Simplecov](https://github.com/colszowka/simplecov) for code coverage
- [Webmock](https://github.com/bblimke/webmock) for stubbing http requests

## Optional configuration

- Set your mail sender in `config/initializers/devise.rb`
- Config your timezone accordingly in `application.rb`.

## Api Docs

http://localhost:3000/api_docs

- Username: `developer`
- Password: `password`
- You can update credentials in `config/initializers/apipie.rb`

## Code quality

With `rake code_analysis` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`
- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`
- [Rails Best Practices](https://github.com/flyerhzm/rails_best_practices#custom-configuration) Edit `config/rails_best_practices.yml`
- [Brakeman](https://github.com/presidentbeef/brakeman) Run `brakeman -I` to generate `config/brakeman.ignore`
- [Bullet](https://github.com/flyerhzm/bullet#whitelist) You can add exceptions to a bullet initializer or in the controller

## Configuring Code Climate

1. After adding the project to CC, go to `Repo Settings`
2. On the `Test Coverage` tab, copy the `Test Reporter ID`
3. Replace the current value of `CC_TEST_REPORTER_ID` on the `config.yml file (.circleci/config.yml)` with the one you copied from CC

## Code Owners

You can use [CODEOWNERS](https://help.github.com/en/articles/about-code-owners) file to define individuals or teams that are responsible for code in the repository.

Code owners are automatically requested for review when someone opens a pull request that modifies code that they own.

## Credits

Rails Api Template is forked from [Rootstrap](https://github.com/rootstrap/rails_api_base) and updated with respect to our requirements by me [Muhammad Soban Akram](https://github.com/sobanakram)
