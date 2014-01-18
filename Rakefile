desc "Given a title as an argument, create a new post file"
task :write, [:title] do |t, args|
  path = File.join("_posts", post_filename(args.title))
  if File.exist? path; raise RuntimeError.new("Won't clobber #{path}"); end
  File.open(path, 'w') do |file|
    file.write post_front_matter(args.title)
  end

  `open -a 'iA Writer' #{path}`
  puts "Now open #{path} in an editor."
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
