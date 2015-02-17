## Monopoly game

## Requirements
  - Ruby 2.1.2
  - Node.js 10.x

## Installation


    # create your RBEnv or RVM or any other Ruby Env sandbox files / variables
    # e.g. for DirEnv
    $ echo "layout ruby" > .envrc && direnv allow

    # will install gems + JS packages
    $ sh/install

    # init database with data
    $ rake db:create db:migrate db:seed


## Development

    # start webpack to compile JS / CSS files
    $ make webpack

    # start rails server
    $ rails s
