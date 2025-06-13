# `Devise::CodeConfirmable`

Devise extension that adds email confirmation via a code that must be entered by the user. Based on Devise's Confirmable module, with the following differences:

1. Still uses the `confirmation_token` attribute in the Devise model, but it holds a (human readable) confirmation code that is sent to the user by email.
2. Redirects the user to the confirmation page after signing up.
3. Mail includes a confirmation code (e.g. 019283) which must be entered in this confirmation page.

    i.e. updates `ConfirmationsController#show` to not make the confirmation via `?token` param, instead only show the view and add a new `ConfirmationsController#update` which compares the user code to `confirmation_token` and confirms the record (i.e. touches `confirmed_at`)

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add devise-code_confirmable
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install devise-code_confirmable
```

## Usage

<!-- TODO: Remove -->
> **Status**: ⚠️ In early development. The following is the expected behavior but may not work yet.

### Getting started

Run the following installation generator.

```
rails generate devise:code_confirmable:install
```

It will:

1. Add an initializer, where you can configure `Devise::CodeConfirmable` globally.
2. Add a base locale file
3. Generates the views (incl. mailers)

### Making a Devise model `:code_confirmable`

#### Columns

To make a Devise model (e.g. a `User` model) `:code_confirmable`, you need it to have the confirmable columns present: (i.e. `confirmation_token`, `confirmed_at`, `confirmation_sent_at` and `unconfirmed_email` if using `:reconfirmable`).
So make sure you uncomment the confirmable (and reconfirmable if applicable) columns from the Devise generated migration.

#### Configuration

Add the `:code_confirmable` module to your Devise model and **do not add `:confirmable`**.

```diff
class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :etc,
-         :confirmable
+         :code_confirmable
end
```

You can configure `Devise::CodeConfirmable` globally in the initializer or on a per-model basis like follows:

```ruby
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :code_confirmable,
         code_alphabet: (0..9), # Default, you can specify a custom one, e.g. `%w[a b c 1 2 3]`
         code_length: 6, # Default
         code_case_insensitive: true, # Default. Will upcase code on generation and comparison.

         # If you want to generate the codes yourself, you can use the following option, overriding the previous ones
         code_generator: ->(record) { '445875' }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/devise-code_confirmable.
