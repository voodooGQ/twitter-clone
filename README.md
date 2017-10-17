# README

- Create VPC with public subnets and igw
- Create EC2 with Amazon AMI in Subnet
- Download pem
- SSH into box
```
    ssh -i ~/path/to/my.pem ec2-user@YOUR.IP.ADDR
```
- Update the AMI - #DIDN'T NEED TO DO THIS
```
    sudo yum -y update
```
- Install Deps -
```
    sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
```
- Install node -
```
    cd ~
    wget http://nodejs.org/dist/v0.10.30/node-v0.10.30-linux-x64.tar.gz
    sudo tar --strip-components 1 -xzvf node-v* -C /usr/local
```
- Install rbenv and setup -
```
    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    exec $SHELL

    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
    exec $SHELL
    source ~/.bash_profile
```
- Install the correct version of ruby and bundler -
```
    rbenv install 2.4.1
    rbenv global 2.4.1
```
- From root dir clone the repo -
```
    cd ~
    git clone https://github.com/voodoogq/twitter-clone
```
- Install/Run Bundler
```
    cd ~/twitter-clone
    gem install bundler
    bundle install
```
- Make sure rbenv is updated with the new gem info
```
    rbenv rehash
```
- Create your secret and copy it
```
    rake secret
```
- Create a `.env` file and add the following:
```
    SECRET_KEY_BASE=THE_SECRET_YOU_JUST_GENERATED
    DB_USER=YOUR_DB_USER_NAME
    DB_PASS=YOUR_DB_PASS
```
- Create/Migrate/Seed the db:
```
    RAILS_ENV=production rake db:create
    RAILS_ENV=production rake db:migrate
    RAILS_ENV=production rake db:seed
```
- Precompile assets:
```
   RAILS_ENV=production rake assets:precompile
```
# START NGINX
- Open up the home directory so nginx can have access
```
    cd /home
    chmod 751 ec2-user
```
- Install nginx
```
    sudo yum -y install nginx
```
- Update the default `nginx.conf` by removing the `server {}` section
```
    cd /etc/nginx
    sudo vim nginx.conf
    /server {

    Remove down to the closing }
```
- Update the `virtual.conf` file
```
    sudo vim conf.d/virtual.conf
    dg
    i

    upstream my_app {
        server 127.0.0.1:3000;  # or the port you configured in puma configuration file
    }

    server {
        listen 80;
        server_name localhost; # change to match your URL, or localhost for simplicity
        root /home/ec2-user/twitter-clone/public; # the path to your app directory + /public
                                    # the default Rails public folder in an app

        location / {
            proxy_pass http://my_app; # match the name of upstream directive which is defined above
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location ~* ^/assets/ {
            # Per RFC2616 - 1 year maximum expiry
            expires 1y;
            add_header Cache-Control public;

            # Some browsers still send conditional-GET requests if there's a
            # Last-Modified header or an ETag header even if they haven't
            # reached the expiry date sent in the Expires header.
            add_header Last-Modified "";
            add_header ETag "";
            break;
        }
    }
```
- Start nginx
```
    sudo service nginx start
```
- Start Puma
```
    cd ~/twitter-clone
    puma -p 3000 -d
```
- Verify it's active by visiting the IP address of the ec2 instance in your
  browser
