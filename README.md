# kali-railway

Want to try out Kali Linux or want to have a mini version of kali linux available at all times? Then feel free to give this project a try:

## Description
This project uses the official [kali linux rolling](https://hub.docker.com/r/kalilinux/kali-rolling/) image to deploy a container which can then be used to install most of the cli tools which comes with kali linux pre-installed. The container runs an SSH server (sshd) on port 22, allowing you to securely access the Kali Linux environment via SSH.


[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/bsL1G9?referralCode=Qs5clj&utm_medium=integration&utm_source=template&utm_campaign=generic)

## Enviroment Variables
  - **USERNAME:** The username which will be used to login via SSH.
  - **PASSWORD:** The password which will be used to login via SSH.

### Railway Default Enviroment Variables
When deploying to Railway, the USERNAME and PASSWORD enviroment variables will be set to a random string, thanks to railway's [template variables](https://docs.railway.app/guides/create#template-variable-functions)
  - USERNAME: A random string of 16 characters containing only alpha-numeric characters (a-z, A-Z, 0-9)
  - PASSWORD: A random string of 32 characters
 
**NOTE:** It is strongly advised to provide the USERNAME and PASSWORD enviroment variables before deploying the project.

To view or edit the USERNAME and PASSWORD enviroment variables, click on the deployed template -> Variables tab

## Using locally

```
# Using docker to create an image and run a container locally
# To build the container image
docker build -t kali-railway .

# To run a demo installation on port 22 with the username set to "admin" and password set to "password"
docker run --rm -e USERNAME=admin -e PASSWORD=password -p 22:22 kali-railway

# Then connect via SSH:
ssh admin@localhost
```

## SSH Connection

The container exposes SSH on port 22. Connect using:
```
ssh USERNAME@HOST
```

When prompted, enter the password set in the PASSWORD environment variable.
