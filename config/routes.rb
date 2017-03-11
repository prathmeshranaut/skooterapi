Rails.application.routes.draw do

  # ~~~~~~~~~~~~~~~~~~~~~~~ API routes ~~~~~~~~~~~~~~~~~~~~~
  
  #user
  post 'api/:version/user' => 'user#create_user'
  put 'api/:version/user/registration_id' => 'user#add_registration_id'
  put 'api/:version/user/notify' => 'user#add_notify'

  #location
  post 'api/:version/location' => 'location#create_location'

  #skoot
  post 'api/:version/skoot' => 'skoot#create_skoot'
  get 'api/:version/skoot/:skoot_id/:location_id' => 'skoot#show_skoot'
  delete 'api/:version/skoot/:skoot_id' => 'skoot#delete_skoot'

  #reply
  post 'api/:version/reply' => 'reply#create_reply'
  delete 'api/r:version/eply/:reply_id' => 'reply#delete_reply'

  #like
  post 'api/:version/like/skoot' => 'like#like_skoot'
  post 'api/:version/like/reply' => 'like#like_reply'
  delete 'api/:version/unlike/skoot/:skoot_id' => 'like#unlike_skoot'
  delete 'api/:version/unlike/reply/:reply_id' => 'like#unlike_reply'

  #feed
  get 'api/:version/feed/:location_id' => 'feed#latest'
  get 'api/:version/feed/category/:category_id/:location_id' => 'feed#category'

  #notifications
  get 'api/:version/notifications' => 'notification#notifications_load'
  put 'api/:version/notifications/read' => 'notification#notifications_read'

  #hashtag
  get 'api/:version/hashtag/:hashtag/:location_id' => 'feed#hashtag'

  #categories
  get 'api/:version/categories/:location_id' => 'category#list'

  #flag
  post 'api/:version/flag/skoot' => 'flag#flag_skoot'
  post 'api/:version/flag/reply' => 'flag#flag_reply'

  # ~~~~~~~~~~~~ admin panel routes starts ~~~~~~~~~~~~~~~~~~~~~
  
  devise_for :admins
  root 'moderator#index'

  # content admin panel
  get 'admin/content' => 'content#index'
  post 'admin/content/zone' => 'content#zone'
  post 'admin/content/categories' => 'content#categories'
  post 'admin/content/skoot' => 'content#skoot'

  get 'admin/content/notif' => 'content#notif'
  post 'admin/content/notif' => 'content#notif'

  # moderation admin panel
  get 'admin/moderator' => 'moderator#index'
  get 'admin/moderator/skoot' => 'moderator#skoot'
  get 'admin/moderator/reply' => 'moderator#reply'
  get 'admin/moderator/autoremoved/skoot' => 'moderator#autoremoved_skoot'
  get 'admin/moderator/autoremoved/reply' => 'moderator#autoremoved_reply'
  
  delete 'admin/moderator/autoremoved/accept/skoot/:skoot_id' => 'moderator#accept_autoremove'
  delete 'admin/moderator/autoremoved/accept/reply/:reply_id' => 'moderator#accept_autoremove'
  delete 'admin/moderator/autoremoved/reject/skoot/:skoot' => 'moderator#reject_autoremove'
  delete 'admin/moderator/autoremoved/reject/comment/:reply_id' => 'moderator#reject_autoremove'
  
  delete 'admin/moderator/accept/post/:skoot_id' => 'moderator#accept'
  delete 'admin/moderator/accept/reply/:reply_id' => 'moderator#accept'
  delete 'admin/moderator/reject/post/:skoot_id' => 'moderator#reject'
  delete 'admin/moderator/reject/reply/:reply_id' => 'moderator#reject'

  # analytics admin panel
  get 'admin/analytics' => 'analytics#index'
  get 'admin/analytics/skoot' => 'analytics#skoot'
  get 'admin/analytics/zone' => 'analytics#zone'
  get 'admin/analytics/user' => 'analytics#user'

end
