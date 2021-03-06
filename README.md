![zemni image](./resources/zemni-title.png)

# Welcome

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="display: block; border-width:0; float: right" align="left" src="https://i.creativecommons.org/l/by/4.0/88x31.png"/></a><br/>

Welcome to the Zemni project. This project is the heart of the [k8sb](https://github.com/v8tix/k8sb) project. 
Zemni is a set of Bash libraries that can help you build Docker containers preventing security vulnerabilities.

## What this guide covers
1. Zemni advantages.
2. Workspace description.
3. Project configuration.
4. Zemni example.

### 1. Zemni advantages.
* :gem: Eliminates chains of Bash commands from Docker files instructions. Instead an instruction becomes an interface to the Bash functions.
* Every function was written using the [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html).        
* Zemni uses Debian's verified packages.      
* These functions can be tested using VMs or containers.
* You can learn how to build a separate set of functionality using pure Bash.        
* Every function returns a detailed message when error occurs.  
### 2. Workspace description.  
The Zemni workspace is composed by a series of directories. They each provide essential scripts that are appropriate to accomplish different tasks.  
* build: 
  * Provides scripts to install Build Tools like Maven.         
* execution:
  * If your app needs a compiler, a runtime or a SDK this is the place where you can include such scripts.  
* lib: 
  * Use this when you need to write custom utilities like logging libraries or to add third party libraries.
* system: 
  * Contains scripts related to Linux administration tasks.
### 3. Project configuration.
* At the root directory you will find a file called common.sh. It contains a set of constants related to each Zemni function.
* :warning: We highly recommend to check this file and upgrade its constants with your personal information.
### 4. Zemni example.
* Here you can find a code fragment that configures the locale on an Ubuntu container: 
* :grey_exclamation: Taken from [Zulu Docker image](https://github.com/zulu-openjdk/zulu-openjdk/blob/master/10-latest/Dockerfile).
  ````
  FROM ubuntu:18.04
  RUN apt-get -qq update && \
      apt-get -qqy install gnupg2 locales && \
      locale-gen en_US.UTF-8 && \
      rm -rf /var/lib/apt/lists/*
  ...
  ````     
* :rocket: Now, using Zemni functions:
  ````
  FROM debian:buster-20200130
  ...
  RUN ["/bin/bash", "-c", "/home/libraries/zemni/system/setup/repos/repos.sh"]
  RUN ["/bin/bash", "-c", "/home/packages/packages.sh"]
  RUN ["/bin/bash", "-c", "/home/libraries/zemni/system/setup/locale/locale.sh"]
  ...
  ````     
## Authors
* Initial work

![v8tix logo](resources/v8tix-logo.jpg) <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Contact us](mailto:info@v8tix.com)</p> 

## License  
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="display: block; border-width:0; float: right" align="left" src="https://i.creativecommons.org/l/by/4.0/88x31.png"/>&nbsp;</a>This work is licensed under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).  