package 'gawk'

node.set['rvm']['user_installs'] = [
  {
    :user => 'vagrant',
    :default_ruby => 'system',
    :rubies => ['2.2.3'],
    :global_gems => [{ :name => 'bundler' }]
  }
]
