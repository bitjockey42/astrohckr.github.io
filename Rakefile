desc "Given a title as an argument, create a new post file"
task :write, [:title] do |t, args|
  unless file_exists? file_path(args.title)
    create_post_with_title args.title, file_path(args.title)
    open_file_in_editor file_path(args.title)
  end
end

def file_exists?(file_path)
  if File.exist? file_path
    raise RuntimeError.new("Sorry, #{file_path} already exists!")
  end
end

def create_post_with_title(post_title, file_path)
  File.open(file_path, 'w') do |file|
    file.write post_front_matter(post_title)
  end
end

def open_file_in_editor(file_path)
  `open -a 'iA Writer' #{file_path}`
  puts "Now open #{file_path} in an editor."
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
