FROM ruby:2.2.3

RUN apt-get update -qq
RUN apt-get install -y nodejs

ENV JEKYLL_DIR /jekyll_src
RUN mkdir $JEKYLL_DIR
WORKDIR $JEKYLL_DIR

ADD Gemfile* $JEKYLL_DIR/
RUN bundle install

ADD . $JEKYLL_DIR
