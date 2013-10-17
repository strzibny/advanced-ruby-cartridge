# OpenShift Advanced Ruby Cartridge
Ruby cartridge, which is used in Openshift, supports by default only passenger server running on Apache. But this Advanced Ruby cartridge allows you to use other popular servers, to be specific **puma**, **unicorn**, **thin**, **rainbows** and **passenger**. And you are allowed to switch Ruby environment to **JRuby**!

This for example means you can take advantage of websockets or better performance for your specific application. Not speaking about advantages of JRuby! Especially for production servers and enterprise applications.


How it Works
------------
Make sure you have newer version of rhc installed, if not update your rhc

	gem update rhc

It's standalone cartridge, so install it like this

	rhc app create YOUR_APP_NAME http://cartreflect-claytondev.rhcloud.com/reflect?github=pbrazdil/openshift-advanced-ruby-cartridge


Managing webserver
-----------------------

By default passenger webserver is used. In order to change it we will use new feature of <code>rhc</code> which allows us to change environment variables. Set name of the server to <code>OPENSHIFT_RUBY_SERVER</code> variable.

	# supported are (for default ruby environment): puma, unicorn, rainbows, thin, passenger
	# supported for jruby are: puma

	rhc env set OPENSHIFT_RUBY_SERVER=puma -a YOUR_APP_NAME

To take effect you need to either restart your application or deploy your code again. 

	rhc app restart YOUR_APP_NAME
	
You can check which server is running by using this command

	rhc ssh YOUR_APP_NAME '~/advanced-ruby/bin/control server'


If you are using Gemfile you need to add gem with your selected server. In this case it would be

```ruby
group :production do
	gem 'puma'
end
```

Changing Ruby environment to JRuby
----------------------------------

By default classic ruby implementation is used, but this cartridge also supports JRuby which can be switched as easy as changing webserver. You can switch to JRuby and vice versa in anytime, not just before first deploy.


    # for default ruby implementation
    rhc env set OPENSHIFT_RUBY_IMPLEMENTATION=default -a YOUR_APP_NAME

    # for jruby
    rhc env set OPENSHIFT_RUBY_IMPLEMENTATION=jruby -a YOUR_APP_NAME

Ruby environment is automatically changed only after new deploy of your code. (= not restarting cartridge)

Check which Ruby environment is currently running by using

	rhc ssh YOUR_APP_NAME '~/advanced-ruby/bin/control ruby-implementation'


Example Rails application
-------------------------

If you have any problems with running application using this cartridge, take a look at my example Rails application which supports either JRuby or default Ruby environment.
