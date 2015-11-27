FROM jekyll/jekyll:pages

ENV JEKYLL_DIR /jekyll_src
RUN mkdir $JEKYLL_DIR
WORKDIR $JEKYLL_DIR

ADD Gemfile* $JEKYLL_DIR/
RUN bundle install

ADD . $JEKYLL_DIR
