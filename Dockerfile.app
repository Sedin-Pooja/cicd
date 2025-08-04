FROM 156916773321.dkr.ecr.ap-south-1.amazonaws.com/pooja/rails_app:ruby_base
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
RUN RAILS_ENV=production bundle exec rake assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-e", "production", "-b", "0.0.0.0"]

