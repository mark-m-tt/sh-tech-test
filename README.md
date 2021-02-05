# Tech Test

## Brief

Your customer would like a simple web application to work out if a given postcode is within their
service area.

Create a form where the input is a UK postcode.

When submitting the form, the response should tell the user if the postcode is allowed or not.

There’s no need to add any styling.

We are using the Postcodes.io REST API as our source for data. The service area is described by
the following rules:

1. Postcodes are grouped into larger blocks called LSOAs. This is returned from the API
when we query a postcode.<br /> We want to allow any postcode in an LSOA starting
"Southwark" or "Lambeth". Example postcodes for these LSOAs are SE1 7QD and SE1
7QA respectively.

2. Some postcodes are unknown by the API or may be served despite being outside of the
allowed LSOAs.<br /> We need to be able to allow these anyway, even though the API does not
recognise them.<br /> SH24 1AA and SH24 1AB are both examples of unknown postcodes that
we want to serve.

3. Any postcode not in the LSOA allowed list or the Postcode allowed list is not servable.<br />
Please note that no guarantees about the format of the input can be given, and the allowed lists
will need to be changed from time to time.

Documentation for the Postcodes.io API can be found at http://postcodes.io

## Up and running

```
$ git clone git@github.com:mark-m-tt/sh-tech-test.git
$ cd sh-tt
$ bundle install
```

Running specs:
```
$ bundle exec rspec
```

Running rubocop:
```
$ bundle exec rubocop
```

Running the app:
```
$ rails s
```

## Using the app

- Head to '/'
- Enter a postcode
- See if it falls within either the allowed LSOA's or the allowed postcodes

## Notes

- Contemplated turning off the RSpec Boolean cop, the syntax of some of the boolean matchers are less than attractive, but left it for convention's sake.
- Where to format the user input. Considered extracting to a separate class but felt like overkill for one line of relatively simple regex in the controller.
- Stubbing API calls in feature tests. If this were a real world app I'd imagine these would be limited.<br />  Fire one API call per test run to ensure API is up, then stub the rest of the calls.
- Contemplated writing the application as a straight rack application, however realistically <br /> if a client asked me to build a user facing web application it would almost always be rails.
- Unsure what level of validation was required.<br /> Contemplated taking one long regex from online to validate postcode but this felt more appropriate (while less accurate and slightly less performant).
- Unsure what level of generosity to give when stripping out non alpha-numeric characters from the postcode.<br />  Decided to accept whatever we could reasonably infer irrelevant of number of spaces / symbols.
- Location checker arguments
  - Could have simply fed in the lsoa / postcode_data hash and removed the coupling to the API client, however <br />that would have meant calling the API before checking the postcode against the allowed list (possibly wasting the call)
  - Other option was to extract checking the postcode against the allowed list before hitting the location checker, <br />but that felt like defeating the point of the location checker class
