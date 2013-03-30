require 'baseball_data_loader'


namespace :baseball  do

  desc "Load data from the supplied xml file (defaults to db/1998statistics.xml)"
  task :upload, [:filename] => :environment do |t, args|
    args.with_defaults(:filename => BaseballDataLoader::DEFAULT_DATA_FILE)
    loader=BaseballDataLoader.new
    loader.load(args[:filename])
  end

end