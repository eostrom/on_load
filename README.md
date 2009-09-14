on_load
=======

This plugin provides simple methods for marking JavaScript to be run
after the DOM is loaded. This is useful when writing unobtrusive
JavaScript.

The generated code uses the dom:loaded event from Prototype. If you're
not using Prototype, this plugin won't work for you.

This plugin has been tested on Rails 2.3.4.

The `on_load` helper
--------------------

This Ruby code:

    on_load do |page|
      page.select('div.tabcontent').invoke('hide');
    end

generates this JavaScript code:

    document.observe("dom:loaded", function() {
      $$('div.tabcontent').invoke('hide');
    });

So does this:

    on_load("$$('div.tabcontent').invoke('hide');");

So does this, in an ERB file:

    <% on_load do %>
      $$('div.tabcontent').invoke('hide');
    <% end %>

So does this, in an RJS file:

    page.on_load do
      page.select('div.tabcontent').invoke('hide');
    end

The `on_load_tag` helper
------------------------

If you're not already in a JavaScript context, you may want to create
one. The `on_load_tag` helper works like `on_load`, but wraps its output in a `script` tag, a la `javascript_tag`.

    <% on_load_tag do %>
      $$('div.tabcontent').invoke('hide');
    <% end %>

generates:

    <script type="text/javascript">
    //<![CDATA[
    document.observe("dom:loaded", function() {
      $$('div.tabcontent').invoke('hide');
    });
    //]]>
    </script>

as do the other variations you'd expect from `on_load` (but not
`page.on_load`). HTML options may be passed in for the `script` tag:

    on_load_tag("$$('div.tabcontent').invoke('hide');",
      :charset => 'UTF-8')

Related work
------------

Oliver Steele's [JavaScript Fu][jsfu] plugin does roughly this, along
with other things. Unlike `on_load`, it supports jQuery if jRails is
installed. However, it's a little less flexible; it can only be used
as `page.onload`, when you're already in an RJS context.

[jsfu]: http://github.com/osteele/javascript_fu/tree/master

Testing note
------------

To run the plugin's tests, you must also install [`plugin_test_helper`][pth]. This is not required if you just want to use `on_load`.

[pth]: http://github.com/pluginaweek/plugin_test_helper/tree/master

Copyright (c) 2009 Erik Ostrom, released under the MIT license
