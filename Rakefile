desc "Given a title as an argument, create a new post file"
task :write, [:title] do |t, args|
  filename = "#{Time.now.strftime('%Y-%m-%d')}-#{args.title.gsub(/\s/, '_').downcase}.md"
  path = File.join("_source/_posts", filename)
  if File.exist? path; raise RuntimeError.new("Won't clobber #{path}"); end
  File.open(path, 'w') do |file|
    file.write <<-EOS
---
layout: post
title: #{args.title}
date: #{Time.now.strftime('%Y-%m-%d %k:%M:%S')}
---
    EOS
    end
    `open -a 'iA Writer' #{path}`
    puts "Now open #{path} in an editor."
end
