# Project Title: RackeTwitter

### Developers
[Nicholas Finocchairo](https://github.com/nickfinocchiaro)

[Harrison Desjardins](https://github.com/HTDesjardins)

### About
RackeTwitter is a small Twitter bot created in Racket. 
It uses a simple GUI and the oauth-single-user library created by [Stephen Charles] (https://github.com/StephenCharles/Racket-OAuth1.0a) to allow the user to enter their Consumer Key (API Key) the consumer Secret, the Access Token, and the Secret Access token to create a tweet bot that is implemented in Racket. These alpha-numeric keys/tokens provided via [Twitter's Dev Site] (https://apps.twitter.com/) when you create a twitter app.  

### Data set or other source materials
If you will be working with existing data, where will you get those data from? (Dowload it from a website? access it in a database? create it in a simulation you will build....)

How will you convert that data into a form usable for your project?  

Do your homework here: if you are pulling data from somewhere, actually go download it and look at it. Explain in some detail what your plan is for accomplishing the necessary processing.

If you are using some other starting materails, explain what they are. Basically: anything you plan to use that isn't code.

### Deliverable and Demonstration
By the end of this project we want to be able to demo an app that allows the user to connect to their twitter acount, look up specific hashtags, and tweet/retweet.  For the live demo we could log into an acount and tweet something.  We can then prove it worked by showing the tweet on the twitter website.

### Evaluation of Results
How will you know if you are successful? 
A brief expectation of our results would be that user is able to post a tweet to their account and then go and view that tweet on another
brower or application. For quantitative search results we will be comparing our results of a hashtag search to that of a hashtag search
on twitter's website. 

## Screencaps

### First Milestone (Fri Apr 15)
The basic GUI should be set up for testing and allow the user to give their username and password.

### Second Milestone (Fri Apr 22)
The GUI will allow the user to login to twitter and make a basic post. We have decided not to hide keys and tokens from the user because they are fairly long and more than likely the user will be copying and pasting them in from another source. 

### Final Presentation (last week of semester)
By this time the GUI should be cleaned up and should allow the user to search for specific hashtags and retweet.

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

### Harrison Desjardins @HTDesjardins
I will be working on the GUI portion of the project.  I hope by the first milestone to have a basic gui with a login screen that will take a username and password.  By the second milestone I want to have the gui allowing the user to login with their password being hidden when typed and I would like the user to be able to post tweets.  By the final milestone I would like to have the gui set up for the search and retweet functions.  I would also want to clean it up and make it look nice by this point.

### Nick Finocchiaro @nickfinocchiaro
Nick will be working on the backend of the project. This includes working with the OAuth Racket library as well as creating a new twitter app to obtain the access tokens needed to communicate with the database. This library allows us to securely connect to twitter and query the data base for tweets as well as post them. For the first milestone, I hope to have a working login screen that will acceptthe user's account name and password and successfully log them in. Second milestone will be that the user is able to post a tweet. The Final milestone is that the user can seach a hashtag and have the results returned to the gui. Twitter will return all query's in JSON format so I will also need to be implementing a JSON parser to make the ouput readable for the common user. 
