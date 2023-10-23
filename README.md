# Koombea code challenge

## Getting Started

These instructions will help you set up and run the project on your local machine for development and testing purposes.

### Prerequisites

Make sure you have the following software/tools installed on your machine:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Installing

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/Freivincampbell/Koombea-challenge.git
   ```

2. Change into the project directory:

   ```bash
   cd Koombea-challenge
   ```

3. Copy .env.example to .env:

   ```bash
   mv .env.example .env
   ```

4. Build and start the Docker containers:

   ```bash
   docker-compose -f docker-compose.local up
   ```

5. Access your Rails application in your web browser at [http://localhost:3000](http://localhost:3000).

## Built With

- [Ruby on Rails](https://rubyonrails.org/) - The web framework used
- [Devise](https://github.com/heartcombo/devise) - For user authentication
- [Nokogiri](https://github.com/sparklemotion/nokogiri) - For parsing HTML and XML
- [HTTParty](https://github.com/jnunemaker/httparty) - For making HTTP requests
- [Bootstrap](https://getbootstrap.com/) - For styling the web application
- [Will Paginate](https://github.com/mislav/will_paginate) - For pagination
- [Kaminari](https://github.com/kaminari/kaminari) - An alternative pagination gem
- [pg](https://rubygems.org/gems/pg) - PostgreSQL adapter for ActiveRecord
- [Sidekiq](https://github.com/mperham/sidekiq) - For background processing

## Authors

- Freivin Campbell
