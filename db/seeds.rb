Zone.create(:name => 'Home', :lat_min => 0, :lat_max => 0, :lng_min => 0, :lng_max => 0) if Zone.count == 0
puts "Zone Home created"
Category.create(:name => "Random") if Category.count == 0
puts "Random category created"
Flag.create([{:name => "Abusive"},{ :name => "Bullying"},{ :name => "Violence"},{ :name => "Spam"},{ :name => "Other"}, {:name => "Auto"}])	if Flag.count == 0
puts "Flags created"
User.create([{:device => "af6c88b31611ca90" },{:device => "845d79d6c7aa87ea"},{:device => "845d79d6c7aa87ea"},{:device => "67f1efe9c152cc75" },{:device => "315cab2e2ec37310" }]) if User.count == 0
puts "Seed users created"
Location.create([{:lat => 0, :lng => 0, :user_id => 1},{:lat => 0, :lng => 0, :user_id => 2},{:lat => 0, :lng => 0, :user_id => 3},{:lat => 0, :lng => 0, :user_id => 4},{:lat => 0, :lng => 0, :user_id => 5}]) if Location.count == 0
puts "Seed locations created"
Admin.create(:email => "admin@skooterapp.com", :password => "janakpuriCCD", :user_type => 1) if Admin.find_by(:email => "admin@skooterapp.com").present? == false
Admin.create(:email => "moderator@skooterapp.com", :password => "iamamod@skooter", :user_type => 2) if Admin.find_by(:email => "moderator@skooterapp.com").present? == false
puts "admin and moderator account created"
puts "Seed Done! Enjoy."