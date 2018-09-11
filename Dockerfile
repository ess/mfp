FROM ruby:2.5

RUN apt-get update && apt-get install -y \
  build-essential \
  rsync \
  wamerican \
  nodejs

RUN mkdir -p /app
WORKDIR /app

COPY . ./
RUN gem install bundler && bundle install

CMD ["bash"]
