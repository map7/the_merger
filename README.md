# TheMerger

A mail merge gem which allows you to do the following;
- link to a table eg: clients. 
- dynamically collects fields from the linked table and displays them in a helper drop down box
- creates a letters table to store you custom letters to be mail merged
- does the mail merging part which is to regex a body of text and replace with fields
- manages bulk emails
- manages scheduled emails (optional)

## Installation

Add this line to your application's Gemfile:

    gem 'the_merger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install the_merger

## Configure

Create a yaml file in your config directory called 'the_merger.yml' with something like this

    ---
    merge_model: "Client"

## Usage

Currently it's just one method and this is how you pass it information

    body = "Dear [firstname] [lastname], Please update your listing, from Mick"
    TheMerger.merge_fields(body, "firstname", "lastname")


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

- Get all users from the users table
- Mail merge and output to the screen
- Create a generator which creates a config file, or read from environment.rb?
- Make the table a variable
- Create a method to get all fields from the selected table.
- Create a helper method to have a dropdown of fields

