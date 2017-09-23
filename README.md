# Docker image Debian Stretch+NGINX+PHP7.1-FPM

A docker image to quick deploy php7 applications with nginx based on debian

## Getting Started

KISS

### Prerequisites

install [docker](https://www.docker.com) 


### Installing

Clone this repository:
```
git clone https://github.com/mcezzare/docker-deb-stretch-php7.1-nginx.git
```
Enter the docker-build folder
```
./docker_build.sh 
```

And on finish

```
./docker_compose_run.sh
```

Open your favorite Browser and navigate to http://localhost:8080/ and you'll see phpinfo()

## Running the tests

composer is installed, create a task test to invoke phpunit ;)


## Deployment

Your root app folder is public, where you can use the index.php for bootstrap  your app or a dispatcher you may prefer.
OBS: if you don't want to use a dispatcher or index.php, remove the configuration with the rewrite rule at default.conf
```
location / {
        try_files $uri /index.php$is_args$args;
        index  index.php ;
    }
```

## Built With
Sublime text : rulez ;)

## Contributing
soon

## Versioning

soon
## Authors

* **Mario Cezzare** - *Initial work* - 
* [Personal web site](http://www.mcezzare.com.br)
* [Linkedin](https://www.linkedin.com/in/mcezzare/) 

## License

soon...

## Acknowledgments

I was tired of using php docker images with strange configurations, and i don't want to leave Infrastructure configurations inside the applications folder, so it's only up the container on terminal inside the docker_build folder and start to build a pretty app ;)