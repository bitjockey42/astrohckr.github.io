# README

This is the repo hosting the source for my blog at [hckr.es](http://hckr.es).

## Setup

Install all gems specified in the `Gemfile`:

    bundle install --binstubs .bundle/bin

## Usage

To preview the site on the local server:

    rake preview

To build the site (and generate tags):

    rake build

To write a new post and edit it with your editor of choice:

	rake write TITLE='Some clever title here'

