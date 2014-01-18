desc "Given a title as an argument, create a new post file"
task :write, [:title] do |t, args|
  post_title = post_title(args)
  unless file_exists_at_path? file_path(post_title)
    create_post_with_content post_front_matter(post_title), file_path(post_title)
    open_file_in_editor file_path(post_title)
  end
end

def post_title(args)
  # This is necessary because Rake interprets arguments with commas in them,
  # even if they are in a string, as separate arguments.
  # So if you pass in "Testing's easy, but, really?" as the title, 
  # args.title will be "Testing's easy"
  # args.extras will be ["but", "really"]
  if !args.extras.empty?
    string = ", #{args.extras.join(", ")}"
  else
    ""
  end
  "#{args.title}#{string}"
end

def file_exists_at_path?(file_path)
  if File.exist? file_path
    raise RuntimeError.new("Sorry, #{file_path} already exists!")
  end
end

def create_post_with_content(content, file_path)
  File.open(file_path, 'w') do |file|
    file.write content
  end
end

def file_path(post_title)
  File.join("_posts", post_filename(post_title))
end

def post_filename(post_title)
  "#{Time.now.strftime('%Y-%m-%d')}-#{sanitize(post_title)}.md"
end

def sanitize(post_title)
  post_title.
    gsub(/[^0-9a-z\s]/i, '').
    gsub(/\s/, '-').
    downcase
end

def post_front_matter(post_title)
%Q(---
layout: post
title: #{post_title}
date: #{Time.now.strftime('%Y-%m-%d %k:%M:%S')}  
---)
end

def open_file_in_editor(file_path)
  `open -a '#{text_editor}' #{file_path}`
  puts "Opening #{file_path} in #{text_editor}."
end

def text_editor
  'iA Writer'
end

