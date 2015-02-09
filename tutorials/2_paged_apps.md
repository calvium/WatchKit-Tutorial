# Paged Apple Watch Apps

##Introduction

Last time we had a look at [how to create a hierarchical app using tables and push segues](#). This time we're going to take a brief look at the alternate navigation by creating a paged app. 

##Interface Builder

We can actually achieve a paged app with just the interface builder. The first thing to do is drag out a single Interface Controller and set the background to a red colour. Next we need to move the Main Entry point from the hierarchical app to point to this new Interface Controller.

Next you can to drag out a couple mre Interface Controllers and set their backgrounds all to different colours. To hook them together by ctrl click on the first Interface Controller and drag to the second Interface Controller, and it should set up add a "next page" segue.

![Imgur](http://i.imgur.com/m9jxZT5.png)

After stringing all the screens together, you should be able to run your app again and swipe between several colours.

![Imgur](http://i.imgur.com/YM0ofPd.png)

##Conclusion

All my project code is available on GitHub at https://github.com/calvium/WatchKit-Tutorial if you got stuck or want to see what I did. Next we're going to look at how to use a context menu to display a modal dialog complete with a static map!