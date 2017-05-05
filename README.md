# nginx-subdomain-generator-script
A bash script that is creating subdomain with given parameters with Nginx in the directory ```/var/www```.
The original script and a tutorial on how to manually create server blocks can be found in here:

http://clubmate.fi/how-to-make-an-nginx-server-block-manually-or-with-a-shell-script/

I updated and modified the code in order to use it for adding subdomains to an existing system by using Nginx server blocks. 

## Usage

Download the file using `wget`:
```bash
# Download the file and save as SubdomainGenerator.sh
wget -O SubdomainGenerator.sh https://raw.githubusercontent.com/karakanb/nginx-subdomain-generator-script/master/SubdomainGenerator.sh

# Change mode of the script to executable.
chmod +x SubdomainGenerator.sh

# Run the script with the subdomain and the parent domain as the parameters.
sudo ./SubdomainGenerator.sh foo example.com

```

This will generate a subdomain as ```foo.example.com```. Don't forget to create the subdomain from your DNS provider to point the same IP address of the server itself, this is out of Nginx's scope.

It uses standard Nginx config files, and creates the files to be served under the folder `/var/www` with the structure as `/var/www/foo/public_html`, or `/var/www/mySubDomain/public_html`. The choice of folder where to create the serving files can be edited with the `$WEB_DIR` variable in the beginning of the program. 

For the sake of simplicity, a more basic syntax may be created with `alias GenerateSubdomain='sudo ./SubdomainGenerator.sh'`, which allows you to call the command as `GenerateSubdomain mysubdomain mymaindomain.com`. 

--------

## License
This script is licensed under the MIT License.