require 'open-uri'

task :update do
  sha = open("https://github.com/defunkt/jquery-pjax/commit/master").readlines.grep(/<title>/)[0][/\b[0-9a-f]+\b/, 0]
  message = "Upgrade pjax to #{sha}"

  data = open("https://raw.github.com/defunkt/jquery-pjax/master/jquery.pjax.js").read
  File.open("vendor/assets/javascripts/jquery.pjax.js", 'w') { |f| f.write data }

  sh "git add vendor/assets/javascripts/jquery.pjax.js"
  sh "git commit -m '#{message}'"
end
