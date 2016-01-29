## WeMessage API and database server

### Dependencies
* Ruby on Rails
* PostgreSQL

### Installing WeMessage API
1. Install ruby 2.2.x on your server.
2. Clone this repository to your development environment.
3. In the root directory of the repository, run the ```bundle``` command.
4. Run ```rake db:create```
5. Run ```rake db:migrate```
6. Run ```rails s``` to start the server.
7. In your development environment, the server will run on localhost:3000

### API Endpoints
* Base route: ```https://obscure-forest-50106.herokuapp.com```
* Login: ```/authenticate```
* Registration: ```/register```
* User information: ```/accounts/ACCOUNT_ID```
* Account's contacts: ```/account-contacts```
* Message thread: ```/messages/sender/SENDER_ID/recipient/RECIPIENT_ID```

#### All routes require authorization token other than login and registration
