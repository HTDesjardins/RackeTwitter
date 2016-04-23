#lang racket
;;
;;
;; Welcome to RackeTwitter!
;;
;; RackeTwitter is twitter bot created by Nicholas Finocchiaro and Harrison Desjardins
;; This app allows a user to enter their app information provided by twitter
;; into the following four fields and make calls to the twitter api. 
;;
;; Below are some test consumer keys and access tokens:
;; consumer-key: qiq3l39bbTmhLAjFApS2XQLZD
;; consumer-secret: KiQscXset9kwujU5gaTM5uW8qA38KJMGOhLBTekUjDUOPO65O6
;; access-token: 286304751-1nFPR2ssNKI73MHgq6UgMbyBKAjwQOyUKY3H8FRM
;; access-token-secret: xNnZo3r3AgxadxQU8EA7jaklfoBDCrIN7JJaKOMI1jc1O
;; 
;; Please see the README.MD file on our github repository for instructions on how to create your 
;; own twitter app and test out RacketTwitter for yourself. 


(require "oauth-single-user.rkt"
  racket/gui/base)

;; initialize twitter-oauth obj as null
(define twitter-oauth '())

;; procedure for setting the key/token values that user has entered for their account. 
(define (twitter-obj key secret-key token secret-token)
  (set! twitter-oauth (new oauth-single-user%  
     [consumer-key key]
     [consumer-secret secret-key]
     [access-token token]
     [access-token-secret secret-token])))

;****************************************************************************************START WINDOW***********************************************************************************
;Starting frame for RackeTwitter
(define frame (new frame% [label "RackeTwitter"]
                          [width 300]
                          [height 300]))

(define panel1 (new horizontal-panel% [parent frame]
                                      [alignment '(center bottom)]))


;Button to log in
(new button% [parent panel1]
             [label "Log in"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send dialog show #t))])

(new button% [parent panel1]
             [label "Cancel"]
             [callback (lambda (button event)
                         (send frame show #f))])


;******************************************************************************************LOGIN WINDOW*********************************************************************************
; Create a login window
(define dialog (instantiate dialog% ("Login")
                [width 500]))
 
; Add a text field to the dialog for login
(define consKey (new text-field% [parent dialog] [label "Consumer Key:    "]))
(define consSec (new text-field% [parent dialog] [label "Consumer Secret:"]))
(define token (new text-field% [parent dialog] [label "Access Token:      "]))
(define secToken (new text-field% [parent dialog] [label "Secret Token:       "]))
 
; Add a horizontal panel to the dialog, with centering for buttons
(define panel2 (new horizontal-panel% [parent dialog]
                                     [alignment '(center center)]))
 
; Add Cancel and Ok buttons to the horizontal panel
(new button% [parent panel2] [label "Cancel"]
                            [callback (lambda (button event)
                                        (send dialog show #f))])
(new button% [parent panel2] [label "Ok"]
                             [callback (lambda (button event)
                                         (if (empCheck consKey consSec token secToken)
                                             (send warning show #t)
                                             (begin  (twitter-obj (send consKey get-value) (send consSec get-value) (send token get-value) (send secToken get-value))
                                                     (send dialog show #f) (send consKey set-value "") (send consSec set-value "") (send token set-value "") (send secToken set-value "")
                                                     (send frame show #f) (send inter show #t))))])

(when (system-position-ok-before-cancel?)
  (send panel2 change-children reverse))


;Warning for empty textfield
(define warning (instantiate dialog% ("Error")))

(define warnPanel (new horizontal-panel% [parent warning]
                                         [alignment '(center center)]))

(new button% [parent warning] [label "OK"]
                            [callback (lambda (button event)
                                        (send warning show #f))])

(new message% [parent warnPanel] [label "A textfield is blank!"])

;***********************************************************************************************TWITTER INTERFACE*******************************************************************************

(define inter (new frame% [label "RackeTwitter"]
                          [width 400]
                          [height 175]))

(define search (new horizontal-panel% [parent inter]
                                      [alignment '(center center)]
                                      [style '(border)]))
(define searchButtons (new horizontal-panel% [parent inter]
                                             [alignment '(center center)]))

(define buttonPanel (new horizontal-panel% [parent inter]
                                           [alignment '(center bottom)]))

(new button% [parent buttonPanel] [label "Tweet"]
                                  [callback (lambda (button event)
                                              (send tweetScreen show #t))])

;need to talk with Nick in order to smooth out a few details before writing retweet button
(new button% [parent buttonPanel] [label "Retweet"])

(new button% [parent buttonPanel] [label "Search"]
                                  [callback (lambda (button event)
                                              (send searchScreen show #t))])

(new button% [parent buttonPanel] [label "Log Out"]
                                  [callback (lambda (button event)
                                              (begin (send inter show #f) (send frame show #t)))])

;Can't finish the search show until I talk with Nick
(new message% [parent search] [label "No search results!"])

(new button% [parent searchButtons] [label "Previous"])

(new button% [parent searchButtons] [label "Next"])



;***************************TWEET DISPLAY******************

(define tweetScreen (new dialog% [label "Tweet"]
                                 [width 300]))

(define tweet (new text-field% [parent tweetScreen] [label "Tweet:"]))

(define tweetButtons (new horizontal-panel% [parent tweetScreen]
                                            [alignment '(center bottom)]))

; Button bellow is to post a tweet to twitter checks if the tweet is empty else
; takes the user created string, posts it to twitter and closes the window. 
(new button% [parent tweetButtons] [label "Post"]
     [callback (lambda (button event)
                 (if (eq? "" (send tweet get-value))
                     (send warning show #t)
                     (and (send twitter-oauth 
                                 post-request "https://api.twitter.com/1.1/statuses/update.json" 
                                 (list (cons 'status (send tweet get-value))))
                     (send tweetScreen show #f))))])

(new button% [parent tweetButtons] [label "Cancel"]
                                   [callback (lambda (button event)
                                               (begin (send tweet set-value "") (send tweetScreen show #f)))])

;***************************SEARCH DISPLAY******************

(define searchScreen (new dialog% [label "Search"]
                                  [width 300]))

(define searchText (new text-field% [parent searchScreen] [label "Search:"]))

(define sButtons (new horizontal-panel% [parent searchScreen]
                                        [alignment '(center bottom)]))

;Button bellow is not complete needs to grab string to be sent to twitter
(new button% [parent sButtons] [label "Search"]
                                    [callback (lambda (button event)
                                               (if (eq? "" (send searchText get-value))
                                                   (send warning show #t)
                                                   "stuff"))])

(new button% [parent sButtons] [label "Cancel"]
                                    [callback (lambda (button event)
                                                (begin (send searchText set-value "") (send searchScreen show #f)))])
                                              

;FUNCTIONS

(define (empCheck consKey consSec token secToken)
  (or  (eq? "" (send consKey get-value))
       (eq? "" (send consSec get-value))
       (eq? "" (send token get-value))
       (eq? "" (send secToken get-value))))
  





 


;starts the first frame
(send frame show #t)