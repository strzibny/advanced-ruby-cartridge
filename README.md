# OpenShift Advanced Ruby Cartridge
Ruby cartridge, which is used in Openshift, supports by default only passenger server running on Apache. This advanced ruby cartridge allows you to use other popular servers, to be specific **puma**, **unicorn**, **thin**, **rainbows** and **passenger**.

This for example means you can take advantage of websockets or better performance for your specific application.


How it Works
------------
Make sure you have newer version of rhc installed, if not update your rhc

	gem update rhc

It's standalone cartridge, so install it like this

	rhc app create YOUR_APP_NAME http://cartreflect-claytondev.rhcloud.com/reflect?github=pbrazdil/openshift-advanced-ruby-cartridge

By default passenger webserver is used. In order to change it we will use new feature of <code>rhc</code> which allows us to change environment variables. Set name of the server to <code>OPENSHIFT_RUBY_SERVER</code> variable.


	# supported are these options: puma, unicorn, rainbows, thin, passenger

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










