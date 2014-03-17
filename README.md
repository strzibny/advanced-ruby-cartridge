# OpenShift Advanced Ruby Cartridge
The ruby cartridge, which is used in Openshift, supports by default only Passenger server running on Apache. But this Advanced Ruby cartridge allows you to use other popular servers, to be specific **puma**, **unicorn**, **thin**, **rainbows** and **passenger**. And you are allowed to switch Ruby platform to **JRuby**.

This for example means you can take advantage of websockets or better performance for your specific application. Not speaking about advantages of JRuby, especially for production servers and enterprise applications.


How it Works
------------
Make sure you have newer version of rhc installed, if not update your rhc

	gem update rhc

It's standalone cartridge, so you can install it like this

	rhc app create YOUR_APP_NAME http://cartreflect-claytondev.rhcloud.com/reflect?github=openshift-cartridges/advanced-ruby-cartridge


Managing used webserver
===================

By default, the Passenger webserver is used. In order to change it, we will use a feature of <code>rhc</code> which allows us to change environment variables. The name of your chosen webserver has to be inserted in <code>OPENSHIFT_RUBY_SERVER</code> variable.

If you are missing some webserver, you can take advantage of support for adding custom webserver, more information in next section.

	# supported are (for ruby MRI (by default)): puma, unicorn, thin, passenger
	# supported for jruby are: puma

    # example of selecting webserver puma
	rhc env set OPENSHIFT_RUBY_SERVER=puma -a YOUR_APP_NAME

To take effect, the application must be restated or you must deploy your code again.

	rhc app restart YOUR_APP_NAME
	
You can check which server is running by using this command

	rhc ssh YOUR_APP_NAME '~/advanced-ruby/bin/control server'


If you are using Gemfile you need to add gem with your selected webserver. In this case it would be

```ruby
group :production do
	gem 'puma'
end
```

Using custom webserver
-----------------------
If using a webserver which is not included in this cartridge, you can create custom server control script which defines operations like start, stop and restart of used webserver. This script must be located in application repository in <code>.openshift/action_hooks/server_control</code> and must be executable. Script will be invoked within context of your repository.

For creating your own custom control script use this template.

    #!/bin/bash -e
    source "${OPENSHIFT_RUBY_DIR}/lib/servers"

    function start() {
      # start action here
    }

    function stop() {
      # stop action here
    }

    function restart() {
      # restart action here
    }

    case "$1" in
      start)    start ;;
      stop)     stop ;;
      restart)  restart ;;
      *)        exit 0 ;;
    esac

The variable <code>OPENSHIFT_RUBY_SERVER</code> must be set to <code>custom</code> by running this command <code>rhc env set OPENSHIFT_RUBY_SERVER=custom -a YOUR_APP_NAME</code>.

For inspiration, you can take a look to <code>servers</code> directory, to be specific into <code>control</code> file of some webserver.

It's highly advised to run any ruby command with <code>ruby_context</code> function  (for example <code>ruby_context "puma --help"</code>), use it even for installing gems or you will experienced a lot of problems, especially if you are using JRuby.

If you have problem with debugging I recommend you to ssh into your app (<code>rhc ssh APP_NAME</code>) and test scripts manually by invoking them to see all error messages.

Changing Ruby platform to JRuby
==================================

By default the classic ruby implementation is used, but this cartridge also supports JRuby which can be switched as easy as changing webserver. You can switch to JRuby and vice versa in anytime, not just before first deploy.


    # for default ruby implementation
    rhc env set OPENSHIFT_RUBY_PLATFORM=default -a YOUR_APP_NAME

    # for jruby
    rhc env set OPENSHIFT_RUBY_PLATFORM=jruby -a YOUR_APP_NAME

The ruby platform is automatically changed only after new deploy of your code.

Check which Ruby platform is currently running by using

	rhc ssh YOUR_APP_NAME '~/advanced-ruby/bin/control ruby-implementation'


Example Rails application
=========================

If you have any problems with running your application using this cartridge, take a look at my example Rails application which supports JRuby and also default Ruby environment, https://github.com/pbrazdil/test-app.


If you want to contact me, send me an email on pbrazdil@redhat.com
