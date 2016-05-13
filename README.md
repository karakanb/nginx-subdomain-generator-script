# nginx-subdomain-generator-script
A bash script that is creating subdomain with given parameters with Nginx in the directory ```/var/www```.
The original script and a tutorial on how to manually create server blocks can be found in here:

http://clubmate.fi/how-to-make-an-nginx-server-block-manually-or-with-a-shell-script/

I just updated the code in order to use it just for adding subdomains to an existing system by using Nginx server blocks. 

# Usage

Save the script file with a name like "SubdomainGenerator.sh", and then execute it with two parameters given, first the subdomain, then the parent domain.

Example usage for a non-root user: ```sudo ./SubdomainGenerator.sh foo example.com```. 
This will generate a subdomain as ```foo.example.com```. Don't forget to create the subdomain from your DNS provider to point the same ip address of the server itself, this is out of Nginx's scope.

It uses standard Nginx config files, and creates the files to be served under the folder ```/var/www``` with the structure as ```/var/www/foo/public_html```, or ```/var/www/mySubDomain/public_html```. The choice of folder where to create the serving files can be edited with the ```$WEB_DIR``` variable in the beginning of the program. 

For the sake of simplicity, a more basic syntax may be created with ```alias GenerateSubdomain='sudo ./SubdomainGenerator.sh'```, which allows you to call the command as ```GenerateSubdomain mysubdomain mymaindomain.com```. 
