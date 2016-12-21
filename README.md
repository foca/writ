# Writ: A minimal command pattern implementation

> **writ**, _noun_:<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a form of written command in the name of a court or other legal authority to act, or abstain from acting, in some way.

`Writ` is a minimal [command pattern][pattern] implementation, including input validation, built on top of [Scrivener][scrivener].

[pattern]: http://wiki.c2.com/?CommandPattern
[scrivener]: https://github.com/soveran/scrivener

# Example

``` ruby
# Define your commands
class LogIn < Writ
  attr_accessor :email
  attr_accessor :password

  def validate
    assert_email :email
    assert_present :password
  end

  def run
    user = User.authenticate(email, password)
    assert user, [:email, :not_valid]
  end
end

# And use them
outcome = LogIn.run(req.params)

if outcome.success?
  session[:user_id] = outcome.value.id
else
  outcome.input.password = nil # Don't leak it when rendering the form again
  render "auth/sign_in", errors: outcome.errors, form: outcome.input
end
```

## Install

    gem install writ

## Validations

As with [scrivener][], you should define a `validate` method that defines all validations for the user input. You're also welcome to use validations inside of `run`, when an error can come from the process itself. The example above, where the email/password combination yields no user, is a good example. Another example would be having to make an API call that returns an error.

Take a look at the default [validations](https://github.com/soveran/scrivener#assertions) that come from scrivener, or feel free to define custom ones to suit your domain.

## Why

When using [scrivener][], I tend to add a `run` method to the objects to alter state based on user input alongside the validations. Some people like calling these objects "services", "use cases", "commands", or "interactions".

I find this useful to decouple complex actions from the actors involved in them, and to keep models "thin" by only caring about expressing the domain without burdening themselves with expressing how users can interact with the domain, or with concepts like validation and authorization.

After using this pattern in several production projects, I figured it might as well live in a gem I can reuse instead of copy-pasting code around.

## License

This project is shared under the MIT license. See the attached [LICENSE](./LICENSE) file for details.
