Rails.application.routes.draw do
  # --------- User Routes ---------  
  post   '/users',      to: 'users#create'        # Create a new user
  get    '/users/:id',  to: 'users#show'          # Get user by ID
  get    '/users',      to: 'users#index'         # Get all users
  post   '/users/login', to: 'users#login'        # User login

  # --------- Post Routes ---------  
  get    '/posts',              to: 'posts#index'        # Get all posts
  post   '/posts',              to: 'posts#create'       # Create a post
  get    '/posts/:id',          to: 'posts#show'         # Get a post by ID
  put    '/posts/:id',          to: 'posts#update'       # Update a post
  delete '/posts/:id',          to: 'posts#destroy'      # Delete a post

  # Custom Post Routes  
  put    '/posts/:id/change_title', to: 'posts#change_title'  # Change post title
  get    '/posts/user/:user_id',    to: 'posts#user_posts'     # Get posts by user
end
