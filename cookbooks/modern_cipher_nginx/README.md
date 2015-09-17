### More modan TLS

This recipe makes your enviornment

- add TLSv1.1 and TLSv1.2
- add modern Cipher Suits


### How to use

Only add the line, `include_recipes "modern_cphier_nginx"`,  on `cookbooks/main/recipes/default.rb"


### What to do this recipe

It replaces `/etc/nginx/server/#{app_name}/customers.ssl_cipher` to the `template/default/customer.ssl_cipher.erb` and reload the nginx configuration.



