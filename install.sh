sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install -y vim curl python-software-properties
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update

sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt php5-readline mysql-server-5.5 php5-mysql git-core php5-xdebug

sudo a2enmod rewrite

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i "s/disable_functions = .*/disable_functions = /" /etc/php5/cli/php.ini

sudo service apache2 restart

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
view rawinstall.sh hosted with ❤ by GitHub
First we update apt-get, a package manager – this is just some housekeeping. We then set the MySQL server username and password to root. We then install a bunch of things like cURL, PHP5, Apache, Git and others. The rewrite module of apache is then enabled and error reporting is set. The server is then restarted and composer is installed.

Both my Vagrantfile and my install file are a slightly modified version of Jeffrey Way’s. If you don’t understand everything in the install file don’t worry too much, just reap the rewards.

The final step is to type vagrant up into the terminal or command prompt and wait for Vagrant to do its thing. This will take a while on the first run, so grab a cup of coffee.

Configuring Websites
At this stage you could go into the HTML directory and create a website, install WordPress and so on. However, we don’t really want to run one virtual machine for every website we’re working on. Also, how about referring to our site with something other than 192.168.99.99? By configuring a few things we can get all this done easily.

Type vagrant ssh into Terminal or Command Prompt to access the virtual machine. Type cd /etc/apache2/sites-available to access the directory which stores the current sites. We can use this directory to add virtual hosts. Here’s how: Let’s create a configuration file, which will contain some options for our virtual host. Use touch blog.conf to create a new configuration file. Then, type sudo vi blog.conf to edit the file using vi. To enter “Edit Mode” press I and paste the following code into the file:

Guarantee Stamp1.6 million WordPress Superheroes read and trust our blog. Join them and get daily posts delivered to your inbox - free!
Email address
Your email address
 SUBSCRIBE
<VirtualHost *:80>
ServerName blog.local
DocumentRoot /var/www/blog

<Directory /var/www/blog>
  Options -Indexes +FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
</VirtualHost>