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
;;
;;


(require "oauth-single-user.rkt"
  racket/gui/base)

(define user_name '())
(define password '())

(define twitter-oauth (new oauth-single-user%  
     [consumer-key '()]
     [consumer-secret '()]
     [access-token '()]
     [access-token-secret '()]))

(define (twitter-obj key secret-key token secret-token)
  (set! twitter-oauth (new oauth-single-user%  
     [consumer-key key]
     [consumer-secret secret-key]
     [access-token token]
     [access-token-secret secret-token])))


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
                                             (and  (twitter-obj (send consKey get-value) (send consSec get-value) (send token get-value) (send secToken get-value))
                                                   (send dialog show #f) (send consKey set-value "") (send consSec set-value "") (send token set-value "") (send secToken set-value ""))))])

(when (system-position-ok-before-cancel?)
  (send panel2 change-children reverse))


;Warning for missing a key
(define warning (instantiate dialog% ("Error")))

(define warnPanel (new horizontal-panel% [parent warning]
                                         [alignment '(center center)]))

(new button% [parent warning] [label "OK"]
                            [callback (lambda (button event)
                                        (send warning show #f))])

(new message% [parent warnPanel] [label "Missing a key!"])

;FUNCTIONS

(define (empCheck consKey consSec token secToken)
  (or  (eq? "" (send consKey get-value))
       (eq? "" (send consSec get-value))
       (eq? "" (send token get-value))
       (eq? "" (send secToken get-value))))
  





 


;starts the first frame
(send frame show #t)