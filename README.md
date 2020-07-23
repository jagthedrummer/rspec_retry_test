# Rspec-retry test

This repo illustrates a bug with `rspec-retry` in controller specs. Instance variables in
the controller under test are preserved between retries. But only for controller specs, not
for request specs.

## Controller spec

Run this:
```
SPEC_RETRY_RETRY_COUNT=5 rspec spec/controllers/home_controller_spec.rb
```

You may need to run it more than once to see a failure.

On a failing run you'll see something like this:

```
$ RSPEC_RETRY_RETRY_COUNT=5 rspec spec/controllers/home_controller_spec.rb
before optional assignment @message =
after optional assignment @message = 3
before optional assignment @message = 3
after optional assignment @message = 3
before optional assignment @message = 3
after optional assignment @message = 3
before optional assignment @message = 3
after optional assignment @message = 3
before optional assignment @message = 3
after optional assignment @message = 3
F

Failures:

  1) HomeController GET #index returns a success response
     Failure/Error: expect(assigns[:message]).to eq(1)

       expected: 1
            got: 3

       (compared using ==)
     # ./spec/controllers/home_controller_spec.rb:32:in `block (3 levels) in <top (required)>'

Finished in 0.03946 seconds (files took 0.88404 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/controllers/home_controller_spec.rb:29 # HomeController GET #index returns a success response
```

The output is coming from the `HomeController` and you can see that on the second run (and later) that the
`@message` variable is already set, even though we haven't gotten to the assignment step yet.

## Request spec

The request spec for the same controller does not exhibit the problem.

Run this:
```
RSPEC_RETRY_RETRY_COUNT=5 rspec spec/requests/home_request_spec.rb
```

You may need to run it a few times before seeing any failures and retries.

On a run with retries you'll see something like this:

```
$ RSPEC_RETRY_RETRY_COUNT=5 rspec spec/requests/home_request_spec.rb
before optional assignment @message =
after optional assignment @message = 0
before optional assignment @message =
after optional assignment @message = 0
before optional assignment @message =
after optional assignment @message = 1
.

Finished in 0.03379 seconds (files took 0.57816 seconds to load)
1 example, 0 failures

```

You can see that on each retry the `@message` variable is unset at the beginning of the run, and is not
being carried over between retries.
