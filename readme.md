
## To run this example you will need:

A server running docker with a DNS name pointing to it. (If you don't already have one setup, using [docker-machine]( https://docs.docker.com/machine/get-started-cloud/#examples) can make it easier to setup and deploy to your server.) Your server will need ports 80, 443, and 2222 open to the public.

The following instructions  assume you're using docker-machine. This will definitely work without it, but you'll have to do a bit more manual copying of files. And you'll probably want to clone the repo on your server rather than locally. 

- Clone this repo
- Replace the content of `identity.pub` with your own SSH public key.
- Adjust file permissions:
```
chmod 644 identity.pub
```
- Rename the `.env.sample` file to `.env`and int it replace `replace.this.example.com` with the DNS name of your server and `replace.with.your@email.com` with your email. Letsencrypt has a pretty strict rate limit of 5 per week, so if you find yourself needing to debug things, uncomment the line `LETSENCRYPT_TEST=true`. The test certs will by considered unsecure by browsers but it should let you test the basic functionality without hitting the rate limit.
- Then to launch the docker containers:
```
  eval $(docker-machine env your-server-name)
  docker-compose up
```
- Now on your local machine you can test the tunnel with something like:
```
  python -m SimpleHTTPServer 3000 .
  ./start_tunnel.sh 3000 whatever.your.domain.is
```
- Open browser to whatever.your.domain.is and you should see an "It works!"