Refile.backends['store'] = Refile::Backend::FileSystem.new('public/uploads/')

require 'refile/s3'

  aws = {
    access_key_id: ENV['S3_ACCESS_KEY_ID'],
    secret_access_key: ENV['S3_SECRET_ACCESS_KEY'], 
    region: 'ap-northeast-1',
    bucket: 'portfoliomarks', 
  }

  Refile.cache = Refile::S3.new(prefix: 'cache', **aws)
  Refile.store = Refile::S3.new(prefix: 'store', **aws)