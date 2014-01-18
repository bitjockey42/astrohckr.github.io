---
layout: post
title: Updates to this blog
date: 2014-01-18 13:06:06
tags:
 - site
 - code
 - jekyll
---

There were a couple things missing from the early iterations of this site. Tags didn't exist, the site header didn't look as cool (or useless, depending on your view). Now, however, that's changed.

## Github Pages, Jekyll, and Tagging

Since I'm hosting these pages on *Github Pages*, where `jekyll` plugins are off by default, I had to eschew the use of plugins to get things to look and function the way I wanted them. This involved a combination of [Rakefile](https://github.com/hckr/hckr.github.io/blob/master/Rakefile) wizardry and [liquid template hackery](https://github.com/hckr/hckr.github.io/blob/master/_includes/).

I scoured the interwebz and assembled bits and pieces into the monstrosity that is my `Rakefile` for this site. Chief of these bits and pieces to be helpful was [this](https://gist.github.com/stammy/790778) gist. 

The caveats to this are that I had to create a custom `:build` task to account for tag generation, which itself is a `Rake` task I created. However, this is still much better than manually creating the pages myself.

## Line Numbers in Code Blocks

I really wanted to get code blocks in here and not have to rely on Github gists (useful though they are) for snippets of code.

The Python syntax highlighter [pygments](http://pygments.org/) is what's used by `jekyll` to generate these nicely-formatted blocks of code. However, in order to have highlighting of syntax to work properly, there must be a stylesheet specifically for `pygments`.

I based the syntax highlight css for this site on the [jekyll-github css](https://github.com/aahan/pygments-github-style/blob/master/jekyll-github.css).

To that end, I've added some customizations to how line blocks look in pages. 

Look at this pretty little thing:

{% highlight ruby linenos=table %}
def build_nice_thing(thing)
	puts "WOW. Very meta. Such #{thing}."
end
{% endhighlight %}


### Source and ending notes

You can see the sexy behind-the-scenes action from the [source](https://github.com/hckr/hckr.github.io). 

Clearly, I've been spending more time hacking around with the code for this site than I have writing prose as I promised I would.
