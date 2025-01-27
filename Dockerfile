# Use Phusion Passenger base image for ARM64 (aarch64)
FROM phusion/passenger-ruby33:latest

# Set environment variables
ENV APP_HOME=/app
ENV RAILS_ENV=development

# Create app directory
WORKDIR $APP_HOME

# Install bundler
RUN gem install bundler -v 2.4.22

# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

# Set correct file permissions
RUN chown -R app:app $APP_HOME

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE

ARG EPPO_SDK_KEY
ENV EPPO_SDK_KEY=$EPPO_SDK_KEY

# Precompile assets (optional, for production)
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rake assets:precompile

# Expose Passenger port
EXPOSE 3000

# Start Passenger
CMD ["passenger", "start", "--port", "3000", "--max-pool-size", "1"]
