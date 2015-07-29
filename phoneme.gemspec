Gem::Specification.new do |s|
  s.name = 'phoneme'
  s.version = '0.1.0'
  s.summary = 'Experimental gem to input a word and output a phenome for use in a dictionary file used by PocketSphinx.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/phoneme.rb']
  s.signing_key = '../privatekeys/phoneme.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/phoneme'
end
