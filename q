[1mdiff --git a/assets/stylesheets/blog.css b/assets/stylesheets/blog.css[m
[1mindex 97d0dde..7c1fe91 100644[m
[1m--- a/assets/stylesheets/blog.css[m
[1m+++ b/assets/stylesheets/blog.css[m
[36m@@ -64,10 +64,9 @@[m
 }[m
 [m
 .blog-content pre code {[m
[31m-  font-size: 100%;[m
[32m+[m[32m  padding: 0;[m
   background-color: inherit;[m
   color: inherit;[m
[31m-  border-radius: 4px;[m
 }[m
 [m
 .blog-tag-list {[m
[1mdiff --git a/assets/stylesheets/jekyll-github.css b/assets/stylesheets/jekyll-github.css[m
[1mindex fae721f..7ec31fa 100644[m
[1m--- a/assets/stylesheets/jekyll-github.css[m
[1m+++ b/assets/stylesheets/jekyll-github.css[m
[36m@@ -69,16 +69,17 @@[m
 [m
 /* Line numbers */[m
 .linenodiv { margin-right: -5px; }[m
[31m-.linenodiv pre { [m
[31m-    color: #aaa; [m
[31m-    background-color: #eee; [m
[32m+[m[32m.linenodiv pre {[m
[32m+[m[32m    color: #aaa;[m
[32m+[m[32m    background-color: #eee;[m
     border-right: 2px #dedede solid;[m
     border-left: none;[m
     border-top: none;[m
     border-bottom: none;[m
     border-radius: 0;[m
 }[m
[31m-.code pre { [m
[31m-    border: none; [m
[31m-    border-radius: 0; [m
[31m-}[m
\ No newline at end of file[m
[32m+[m[32m.code pre {[m
[32m+[m[32m    border: none;[m
[32m+[m[32m    border-radius: 0;[m
[32m+[m[32m}[m
[32m+[m[32mpre { white-space: pre; overflow: auto; }[m
[1mdiff --git a/assets/stylesheets/layout.css b/assets/stylesheets/layout.css[m
[1mindex 7c351c6..0faad97 100644[m
[1m--- a/assets/stylesheets/layout.css[m
[1m+++ b/assets/stylesheets/layout.css[m
[36m@@ -1,6 +1,6 @@[m
 .center {[m
     margin: 0 auto;[m
[31m-    width: 650px;[m
[32m+[m[32m    width: 800px;[m
 }[m
 [m
 .row {[m
