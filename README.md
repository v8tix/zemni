![zemni image](./resources/zemni-title.png)

# Welcome

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="display: block; border-width:0; float: right" align="left" src="https://i.creativecommons.org/l/by/4.0/88x31.png"/></a><br/>

Welcome to the Zemni project. This project is the heart of the Drako project. 
Zemni is a set of Bash libraries that can help you build Docker containers preventing [supply chain attacks](https://docs.microsoft.com/en-us/windows/security/threat-protection/intelligence/supply-chain-malware).

## What this guide covers
1. Zemni advantages.
2. Workspace description.
3. Project configuration.
4. Zemni example.

### 1. Zemni advantages.
* :gem: Eliminates Bash commands from Docker files. Instead a Docker file becomes an interface to Zemni functions.
* Every function was written using the [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html).        
* Zemni uses Debian's verified packages.      
* Libraries can be tested using VMs or containers.
* Modularity. You can check how to build a separate set of functionality using pure Bash.        
* Every function returns a detailed message when error occurs.  
### 2. Workspace description.  
The Zemni workspace is composed by a series of directories. They each provide essential scripts that are appropriate to accomplish different tasks.  
* build: 
  * Provides scripts to install Build Tools like Maven.         
* execution:
  * If your app needs a compiler, a runtime or an SDK this is the place where you can include such scripts.  
* lib: 
  * Use this when you need to write custom utilities like logging libraries or to add third party libraries.
* system: 
  * Contains scripts related to Linux administration tasks.
### 3. Project configuration.
* Under the zemni directory you can find a file called common.sh. In this file you will find a set of constants related to each Zemni function.
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
  RUN ["/bin/bash", "-c", "/home/ext/zemni/system/setup/repos/repos.sh"]
  RUN ["/bin/bash", "-c", "/home/pkg/pkg.sh"]
  RUN ["/bin/bash", "-c", "/home/ext/zemni/system/setup/locale/locale.sh"]
  ENV LANG en_US.utf8
  ...
  ````     
## Authors
* Initial work
  * V8TIX - info@v8tix.com   
## License  
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="display: block; border-width:0; float: right" align="left" src="https://i.creativecommons.org/l/by/4.0/88x31.png"/>&nbsp;</a>This work is licensed under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).  