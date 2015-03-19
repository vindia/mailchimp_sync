# MailChimp synchronization script
This script will use a CSV file with member data to sync one or more columns in your Mailchimp lists. I've used it to sync
the active status of members on a Discourse forum to the invite lists in Mailchimp so I could send out a reminder
email to the members who hadn't activated their accounts.

Works great in combination with [vindia/discourse_user_exporter](https://github.com/vindia/discourse_user_exporter).

## Import file format

    email;name;username;title;groups;active

Field      | Required | Description
-----------|----------|------------
`email`    | **Yes**  | The email address of the user
`name`     | No       | The user's full name
`username` | **Yes**  | The user's user name. If none is supplied, this will be generated from the email address.
`title`    | No       | The user's title, e.g. _Vice President of Engineering_
`groups`   | No       | A comma separated list of groups a user should be added to. When left empty, the user will not be added to any specific groups.
`active`   | Yes      | Whether the user is active or not. Should be either true or false.

## Running it

    $ bundle install
    $ ruby mailchimp_sync.rb [/path/to/users.csv]

The `/path/to/users.csv' argument is optional.
