
#!/usr/bin/env bash
#
# Nginx Bash script for generating new subdomain with a new server block.

# Functions
ok() { echo -e '\e[32m'$1'\e[m'; } # Green
die() { echo -e '\e[1;31m'$1'\e[m'; exit 1; }

# Variables
NGINX_AVAILABLE_VHOSTS='/etc/nginx/sites-available'
NGINX_ENABLED_VHOSTS='/etc/nginx/sites-enabled'
WEB_DIR='/var/www'
NGINX_SCHEME='$scheme'
NGINX_REQUEST_URI='$request_uri'

# Sanity check
[ $(id -g) != "0" ] && die "Script must be running as root."
[ $# != "2" ] && die "Usage: $(basename $0) subDomainName mainDomainName"

ok "Creating the config files for your subdomain."

# Create nginx config file
cat > $NGINX_AVAILABLE_VHOSTS/$1 <<EOF
server {
    # Just the server name
    server_name $1.$2;
    root        $WEB_DIR/$1/public_html;

    # Logs
    access_log $WEB_DIR/$1/logs/access.log;
    error_log  $WEB_DIR/$1/logs/error.log;

    # Includes
    # include global/common.conf;

    # Listen to port 8080, cause of Varnis
    # Must be defined after the common.conf include
    #listen 127.0.0.1:8080;
}
EOF

# Creating {public,log} directories
mkdir -p $WEB_DIR/$1/{public_html,logs}

# Creating index.html file
cat > $WEB_DIR/$1/public_html/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
        <title>You are in the subdomain $1.$2</title>
        <meta charset="utf-8" />
</head>
<body class="container">
        <header><h1>You are in the subdomain $1.$2<h1></header>
        <div id="wrapper">
                This is the body of your subdomain page.
        </div>
        <br>
        <footer>© $(date +%Y)</footer>
</body>
</html>
EOF

# Changing permissions
chown -R $USER:$WEB_USER $WEB_DIR/$1

# Enable site by creating symbolic link
ln -s $NGINX_AVAILABLE_VHOSTS/$1 $NGINX_ENABLED_VHOSTS/$1

# Restart
echo "A restart to Nginx is required for the subdomain to be defined. Do you wish to restart nginx?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) /etc/init.d/nginx restart ; break;;
        No ) exit;;
    esac
done

ok "Subdomain is created for $1."
