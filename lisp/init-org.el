;; Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (java . t)
   (http . t)   
   (shell . t)))


;; publish blog
;;(setq org-publish-use-timestamps-flag nil
;;      org-export-date-timestamp-format "%Y-%m-%d %H:%M:%S")
;;(load "~/.emacs.d/org-project.lisp")


;; org-mode set
(require 'org)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-cl" 'org-store-link)
(setq org-log-done t
      org-agenda-files '("~/org/todo.org"
			 "~/org/day-todo.org"))


(defun make-blog-file-name ()
  (interactive)
  (let ((name (read-minibuffer "Name: ")))
    (format "~/blogs/%s-%s.org"
            (format-time-string "%F" (current-time))
            name)))

(setq org-capture-templates
      ;;(keys description type(entry,item,checkitem,table-line,plain) target template properties)
      '(("t"  "Tasks"     entry (file+headline "~/org/tasks.org"     "Tasks")     "** TODO %?\n%i\n%a")
        ("i"  "Ideas"     entry (file+headline "~/org/ideas.org"     "Ideas")     "")
        ("r"  "Reminders" entry (file+headline "~/org/reminders.org" "Reminders") "")
        ("n"  "Notes"     entry (file+headline "~/org/notes.org"     "Notes")     "** 日记标题" :prepend t)
        ("p"  "Projects"  entry (file+headline "~/org/projects.org"  "Projects")  "")
        ("b"  "Blogs"     entry (file          make-blog-file-name)  "")))

;; org html export for jekyll
;; (setq org-publish-project-alist
;;       '(
;; 	("org-cgq"
;; 	 ;; Path to your org files.
;; 	 :base-directory "~/cgq/org/"
;; 	 :base-extension "org"
;; 
;; 	 ;; Path to your Jekyll project.
;; 	 :publishing-directory "~/cgq/jekyll/"
;; 	 :recursive t
;; 	 :publishing-function org-html-publish-to-html
;; 	 :headline-levels 4
;; 	 :html-extension "html"
;; 	 ;; Only export section between <body </body>
;; 	 :body-only t)
;; 
;; 	("org-static-cgq"
;; 	 :base-directory "~/cgq/org/"
;; 	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
;; 	 
;; 	 :publishing-directory "~/cgq/jekyll/"
;; 	 :recursive t
;; 	 :publishing-function org-publish-attachment)
;; 
;; 	("cgq" :components ("org-cgq" "org-static-cgq"))
;; 	))
;; 
;;(setq org-publish-project-alist
;;      '(("blog"
;;	 ;; 源文件目录
;;	 :base-directory "E:/git/blog/org/"
;;	 ;; 选项要发布的文件
;;	 :base-extension "regex"
;;	 :exclude "regex"
;;	 :include '("filename" ...)
;;	 :recursive t
;;
;;       ;; 发布目录
;;	 :publishing-directory "E:/git/blog/"
;;	 :preparation-function
;;	 :completion-function
;;	 
;;	 ;; 指定发布函数
;;	 :publishing-function org-html-publish-to-html
;;	 :htmlized-source nil
;;
;;	 ;; 指定发布导出器的一般选项
;;	 :with-fixed-width 80
;;	 :language "zh-CN"
;;
;;	 :with-author "Chen Guangqi"
;;	 ;;:with-creator t
;;	 :with-date '(("zh-CN" "%Y-%m-%d %H:%M%S"))
;;	 :section-numbers nil
;;	 :with-toc nil
;;	 ;; 指定发HTML布导出器的选项
;;	 :html-doctype "html5"
;;	 ;:html-head-include-default-style nil
;;	 ;:html-head "<link rel=\"stylesheet\" href=\"../css/style.css\" type=\"text/css\">"
;;
;;	 ;; 生成sitemap
;;	 :auto-sitemap t
;;	 :sitemap-filename "index.org"
;;	 :sitemap-title "独狼刺的博客"
;;	 :sitemap-date-format "%Y-%m-%d %H:%M%S"
;;	 ;;:sitemap-sans-extension t
;;	 
;;	 ;; 生成index
;;	 ;; :makeindex t
;;	 )))
(defvar blog-name "chenguangqi.github.io")
(defvar blog-basedir (expand-file-name (format "~/%s" blog-name)))
(defvar blog-drafts-basedir "_drafts")
(defvar blog-posts-basedir  "_posts")
(defvar blog-post-template1
   "#+BEGIN_HTML\n---\nlayout: post\ntitle: %s\nexcerpt: \nkeywords: \"\"\ncategories: \ntags: []\n---\n{%% include JB/setup %%}\n#+END_HTML\n\n* \n\n\n#+BEGIN_HTML\n<!-- more-forword -->\n#+END_HTML\n\n\n#+BEGIN_HTML\n<!-- more -->\n#+END_HTML\n")



(defun  create-post (title)
  "Create a new post."
  (interactive "sPost Title:")
  (save-excursion
    (let ((draft-file (concat blog-basedir "/"
			      blog-drafts-basedir "/"
			      title ".org")))
      (message draft-file)
      
      (if (file-exists-p draft-file)
	  (find-file draft-file)
	(find-file draft-file)
	(insert (format blog-post-template1 title))))))




;; publishing org
(require  'ox-publish)
(setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "~/org/"
         :base-extension "org"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :auto-preamble t)
        ("org-static"
         :base-directory "~/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("org" :components ("org-static" "org-notes"))
        ))

(provide 'init-org)
