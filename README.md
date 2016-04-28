# Project Title: RackeTwitter

### Developers
[Nicholas Finocchairo](https://github.com/nickfinocchiaro)

[Harrison Desjardins](https://github.com/HTDesjardins)

### Overview
RackeTwitter is a small Twitter bot created in Racket. 
It uses a simple GUI and the to allow the user to enter their Consumer Key (API Key) the consumer Secret, the Access Token, and the Secret Access token to create a tweet bot that is implemented in Racket. These alpha-numeric keys/tokens provided via [Twitter's Dev Site] (https://apps.twitter.com/) when you create a twitter app.  

##Screenshot
Run RackeTwitter from DrRacket. The Window below will pop up:

<img src="https://github.com/oplS16projects/RackeTwitter/blob/master/loginscreen.png" width="300">

Proceed to The Login Screen:

<img src="https://github.com/oplS16projects/RackeTwitter/blob/master/keytokenlogin.png" width="400">

After a successful login the user will recieve this window:

<img src="https://github.com/oplS16projects/RackeTwitter/blob/master/homescreen.png" width="400">

##Concepts Demonstrated
Identify the OPL concepts demonstrated in your project. Be brief. A simple list and example is sufficient. 
* **Data abstraction** is used to provide access to the elements of the RSS feed.
* The objects in the OpenGL world are represented with **recursive data structures.**
* **Symbolic language processing techniques** are used in the parser.

##External Technology and Libraries
We used the [Racket Gui library] (https://docs.racket-lang.org/gui/) to wrap the oauth-single-user library created by [Stephen Charles] (https://github.com/StephenCharles/Racket-OAuth1.0a). 

##Favorite Scheme Expressions
####Harrison
```scheme
(new button% [parent searchButtons] [label "Next"]
                                    [callback (lambda (button event)
                                                (if (or (eq? '() search-results) (>= (+ 1 index-of-search) (length search-results)))
                                                    (send warning show #t)
                                                    (begin (set! index-of-search (+ index-of-search 1))
                                                           (send searchDisplay set-label (next-result search-results index-of-search)))))])
```
This is my favorite procedure within the code.  It is my favorite because even though it looks kind of complex, it is actually a really straight foreword procedure.  The code allows the user to change the displayed search result to the the next result.  This procedure even has error checking, which can be seen by the the if statement.  By checking to make sure the index is not larger than the number of elements in the list, we know it can never over step.  Another thing that I like about this code is the fact it uses lambda to create a procedure that runs when the button is clicked.

####Lillian (another team member)
Each team member should identify a favorite expression or procedure, written by them, and explain what it does. Why is it your favorite? What OPL philosophy does it embody?
This expression reads in a regular expression and elegantly matches it against a pre-existing hashmap....
```scheme
(let* ((expr (convert-to-regexp (read-line my-in-port)))
             (matches (flatten
                       (hash-map *words*
                                 (lambda (key value)
                                   (if (regexp-match expr key) key '()))))))
  matches)
```

#How to Download and Run
You may want to link to your latest release for easy downloading by people (such as Mark).

1. After downloading the release unpack the zip into any directory. 
2. Open the file RackeTwitterGUI.rkt in DrRacket
3. Run the file with the play button. 
4. See Screenshots for using the GUI. 
