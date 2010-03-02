# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_startup_session',
  :secret      => '71b2e87298d3b686eb4ad0467c5682e4da6fede88b011e09a10c5c0674ee06b198bea26fa51bc8ba9a5afa7fc97dfaa4a36d859f5d961df28167b2d21e7a40a7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
