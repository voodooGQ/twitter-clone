# README

- Create VPC with public subnets and igw
- Create EC2 with Amazon AMI in Subnet
- Download pem
- SSH into box `ssh ~/path/to/my.pem ec2-user@YOUR.IP.ADDR`
- Update the AMI - `sudo yum -y update`
- Install Deps - `sudo yum install -y git-core zlib zlib-devel gcc-c++ patch
  readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2
  autoconf automake libtool bison curl sqlite-devel`
- Install node -

    cd ~
    wget http://nodejs.org/dist/v0.10.30/node-v0.10.30-linux-x64.tar.gz
    sudo tar --strip-components 1 -xzvf node-v* -C /usr/local

- Install rbenv and setup -

    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    exec $SHELL

    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
    exec $SHELL
    source ~/.bash_profile

- Install the correct version of ruby and bundler -

    rbenv install 2.4.1
    rbenv global 2.4.1

<!--- Install rbenv-vars-->

    <!--cd ~/.rbenv/plugins-->
    <!--git clone https://github.com/sstephenson/rbenv-vars.git-->

- From root dir clone the repo - `git clone https://github.com/voodoogq/twitter-clone`
- Install/Run Bundler

    cd ~/twitter-clone
    bundle install

- Create your secrets `rake secret` and copy it
- Create a `.env` file and add the following:

    SECRET_KEY_BASE=THE_SECRET_YOU_JUST_GENERATED
    DB_USER=YOUR_DB_USER_NAME
    DB_PASS=YOUR_DB_PASS

