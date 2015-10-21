copperegg_webhooks_handler
==========================

* This is example code provided by Uptime Cloud Monitor for our customers who are using Webhooks.
* This ruby code:
*   - runs sinatra on thin;
*   - it completely parses and decodes all Uptime Cloud Monitor webhook system and probe alerts;
*   - each alert type is broken-down to an individual method, which prints a message to
*     stdout;
*   - these individual methods can be modified to execute code to restart your server,
*     scale your number of servers, or whatever else you choose to do.


Requirements
============
sinatra, thin, json

Platform
========
* This code runs on any ruby platform compatable with sinatra.

Usage
============
* For testing your code locally:
* - Open a terminal window on your local dev system
* - clone this repo to your dev system
* - install sinatra, json and thin gems
* - run bundle
* - run the program:
*    ruby webhooks.rb
* - thin / sinatra will start up a local webserver on your dev machine, which can be
*     accessed at localhost:4567
* - create an internet-visible proxy for your local webserver ... for example using
*    proxylocal; (find it at http://proxylocal.com)
*    in a separate terminal window, run proxylocal:4567
*    proxylocal will display a public IP that you can use to access your local web server
* - copy the address provided by proxylocal.com into the 'webhook' field on the alert
*    definitions of your choice.
* - you will see the decoded webhook information displayed on your 'sinatra' terminal.

Links
=====
* [Uptime Cloud Monitor Homepage](https://www.idera.com/infrastructure-monitoring-as-a-service/)
* [ProxyLocal Homepage](http://www.proxylocal.com)
* [Sinatra Homepage](http://www.sinatrarb.com)

