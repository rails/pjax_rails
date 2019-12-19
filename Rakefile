require 'rake/testtask'

task :default => :test
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = ['test/controllers/*_test.rb', 'test/features/*_test.rb']
  t.verbose = true
end

desc 'Update jquery-pjax to last version'
task :update do
  require 'open-uri'
  version = open('https://github.com/defunkt/jquery-pjax/commit/master').readlines.grep(/<title>/)[0][/\b[0-9a-f\.]+\b/, 0]
  message = "Update pjax to #{version}"

  data = open('https://raw.github.com/defunkt/jquery-pjax/master/jquery.pjax.js').read
  File.open('vendor/assets/javascripts/jquery.pjax.js', 'w') { |f| f.write data }

  sh 'git add vendor/assets/javascripts/jquery.pjax.js'
  sh "git commit -m '#{message}'"
end
