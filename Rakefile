require 'rake/testtask'

task :run do
  sh 'rerun "rackup -p 9000"'
end

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end

namespace :db do
  desc 'Print out final schema to file'
  task schema: [:_setup] do
    DB.extension :schema_dumper
    File.open('db/schema.rb', 'w') do |file|
      header = <<~END
      END
      puts 'Writing schema to db/schema.rb'
      file.write(header)
      file.write(DB.dump_schema_migration)
    end
  end
end
