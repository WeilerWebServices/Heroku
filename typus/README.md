# Typus: Admin Panel for Ruby on Rails applications

**Typus** allows trusted users to edit structured content.

## Key Features

- Built-in Authentication and Access Control Lists.
- CRUD and custom actions for your models on a clean interface.
- Internationalized interface ([See available translations][locales])
- Customizable and extensible templates.
- Integrated [paperclip][paperclip] and [dragonfly][dragonfly] attachments viewer.
- Works with `Rails 3.0.X`.
- Tested with latest versions of `1.8.7`, `ree`, `1.9.2` and `jruby`.
- Tested with `SQLite`, `MySQL` and `PostgreSQL`.

## Links

- [Documentation](https://github.com/fesplugas/typus/wiki)
- [Issues](https://github.com/fesplugas/typus/issues)
- [Demo](http://demo.typuscms.com/) ([Code][code])
- [Source Code](http://github.com/fesplugas/typus)
- [Mailing List](http://groups.google.com/group/typus)
- [Gems](http://rubygems.org/gems/typus)
- [Contributors List](http://github.com/fesplugas/typus/contributors)

## Installing

Add **Typus** to your `Gemfile`

    gem 'typus', :git => 'git://github.com/fesplugas/typus.git'

Update your bundle, run the generator and start the application server:

    $ bundle install
    $ rails generate typus
    $ rails server

and go to <http://0.0.0.0:3000/admin>.

## Known Issues

- Dragonfly supported version is 0.8.X.

## License

Typus is released under the MIT license.

[paperclip]: http://rubygems.org/gems/paperclip
[dragonfly]: http://rubygems.org/gems/dragonfly
[code]: https://github.com/fesplugas/typus/tree/master/test/fixtures/rails_app
[locales]: https://github.com/fesplugas/typus/tree/master/config/locales