FROM ruby-3.3.2-v1 
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
RUN RAILS_ENV=production bundle exec rake assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-e", "production", "-b", "0.0.0.0"]
