(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  map(lambda x: append '(first) x), rests)



;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
  (define (helper s x)
    (if (null? s) nil
      (cons (list x (car s)) (helper (cdr s) (+ x 1)))))
  (helper s 0))
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
  
  (cond
    ((= total 0) '(()))
    ((null? denoms) nil)
    ((> (car denoms) total) (list-change total (cdr denoms)))
    (else (append (map (lambda (l) (append (list (car denoms)) l)) (list-change (- total (car denoms)) denoms))
    (list-change total (cdr denoms))))
    )
)
  ; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

(define (zip pairs)
  (if (null? (car pairs)) nil
  (cons (map (lambda (a) (car a)) pairs) (zip (map (lambda (x) (cdr x)) pairs)))))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 18
          expr
         ; END PROBLEM 18
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (append(list form params) (map let-to-lambda body)) 
           ; END PROBLEM 18
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (define lst (zip values))
            (append(list(append(list 'lambda (car lst))  (map let-to-lambda body))) (map let-to-lambda (cadr lst)))
           ; ; END PROBLEM 18
           ))  
        (else
         ; BEGIN PROBLEM 18
         (map let-to-lambda expr)
         ; END PROBLEM 18
         )))

