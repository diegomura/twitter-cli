# ruby-twitter-client

> Simple client for retrieving Twitter data in your terminal.

## Installation

Install required dependencies by running

```bundle install```

## Usage

ruby-twitter-client comes with a built-in CLI to get and show your Twitter data:

```ruby -I lib bin/twitter_client [PARAMETERS]```

### Twitter credentials

Also, you'll have to configure OAuth credentials to access Twitter's API.

By default,the client search for authentication data in
***'./twitter_credentials.yml'***. Otherwise, you'll have to pass
the credentials file as parameter with the **-c** command

#### Credentials format

Credentials must be in YAML format as follows:

```
consumer_key: qJBN...
consumer_secret: 8dgu...
access_token: 104170...
access_token_secret: UnhR...
```

### Parameters
| Command         | Arguments        | Description                             |
|---------------- |:----------------:| ----------------------------------------|
| -c --credentials| credentials_file | Set Twitter authentication credentials  |
| -t --tweet      | hashtag          | Search tweets by hashtag                |
| -u --user       | username         | Get user's bio                          |
| -r --trending   | place_name       | Get trending topics of a specific region|
| -h --help       | -                | Help                                    |

### Examples
#### Get lastest tweets containing #Ruby
```ruby -I lib bin/twitter_client -t "#Ruby"```
#### Get Rails user's bio
```ruby -I lib bin/twitter_client -u rails```
#### Get trending topics from Buenos Aires
```ruby -I lib bin/twitter_client -r "Buenos Aires"```


## Contributing to ruby-twitter-client

* Check out the latest master to make sure the feature hasn't been implemented
or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it
and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a
future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to
have your own version, or is otherwise necessary, that is fine, but please
isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2017 Diego Muracciole. See LICENSE.txt for
further details.
