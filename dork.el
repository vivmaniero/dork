;;; dork.el --- ESPRIT Grade calculator. 

;; Copyright (C) 2022 Aziz Ben Ali

;; Author: Aziz Ben Ali <ba.tahaaziz@gmail.com>
;; Homepage: https://github.com/vivmaniero/dork.el

;; Dork is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; Dork is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Dork.  If not, see <https://www.gnu.org/licenses/>.

;;; Code:

(defun dork-compute-avg (cc tp ex)
  "Computes the average of the provided CC, TP and EX.
CC and TP are optional, but their absence affects how calculations are done."
  (cond ((and (bound-and-true-p cc)
	      (bound-and-true-p tp)
	      (bound-and-true-p ex))
	 (+ (* 0.3 cc) (* 0.2 tp) (* 0.5 ex)))
	((and (not cc)
	      (not tp))
	 ex)
	((and (not cc))
	 (+ (* 0.3 tp) (* 0.7 ex)))
	((and (not tp))
	 (+ (* 0.4 cc) (* 0.6 ex)))))

(defun dork-prompt-compute-course-average ()
  "Prompts the user for grades, returning the average."
  (interactive)
  (let ((course (read-string "Course: " nil nil nil nil))
	(cc (read-string "Continuous Assessment: " nil nil nil nil))
	(tp (read-string "Practicum: " nil nil nil nil))
	(ex (read-string "Exam: " nil nil nil nil))
	(grade-range (number-sequence 0 20))
	(grade-out-of-range-error (message "Grade can neither be negative, nor surpass 20."))
	(omitted-exam-error (message "Grade of exam cannot be omitted.")))
    (message
     (format "AVG of %s: %s"
	     (upcase course)
	     (dork-compute-avg-from-string cc tp ex)))))

(defun dork-compute-avg-from-string (cc tp ex)
  "Computes the average of the provided CC, TP and EX
attempting to parse each number from its respective string.
This is helpful when working with Org tables."
  (let ((cc (string-to-number cc))
	(tp (string-to-number tp))
	(ex (string-to-number ex)))
    (cond ((= cc 0) (dork-compute-avg nil tp ex))
	  ((= tp 0) (dork-compute-avg cc nil ex))
	  (t (dork-compute-avg cc tp ex)))))
