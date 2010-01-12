# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bmaxwell_website_session',
  :secret      => 'bf07ddf370db12f5b9142d0cc257cbf4565cd3dc057e8f9f2a00fc0837267895816010b118b660e30304697f1d33e09d4c32ba1398285cd0eb915bb5cf5bd7a0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
