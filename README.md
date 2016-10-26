
---

[TOC]
#**Build a Todo App With Rails**

This series will build an online todo-list application. The main focus here will be on the backend so I'll just copy and paste prewritten stylesheets for this application. We will learn how to use Rails with some great tools, such as:

 - **Bootstrap** to design responsive pages
 - **Devise** for user authentication and authorization
 - **Font-awesome-rails** for icons

Let's get started

##**Main features**

- **Responsive pages**: The app will be built using a responsive framework to provide optimal viewing for different devices.
- **List**:  Allow users to create lists which will contain many tasks.
-  **Task**: Allow users to create/completed/delete tasks.
- **User authentication and authorization**: allow users sign up and sign in. Restrict access only to signed in users.

##**Skills needed**

- Intermediate level of HTML/CSS3
- Basic Ruby on Rails knowledge

##**Tools** 
- **Ruby 2.2 or later** - Programming language
- **Rails** - Back-end framework
- **Bootstrap 3** - Front-end css framework 
- **Devise** - User authentication
- **Font-awesome-rails** - Icons

> **Note**: The source code is available on this [Github repository](https://github.com/simposk/planner).

---
#**Step 1: Initialize The Project**
##**Create project**
Let’s create a new Rails application. We’re using Sqlite3 as our database. Open your terminal and type:

    $ rails new Plannr
    $ cd Plannr
    $ git init
    $ git add .
    $ git commit -am "Initial commit"

Now, if you don't have github set up on your computer go to [Github](https://github.com/) and create an account.  
Follow [this tutorial on how to set up ssh key.](http://devmarketer.io/learn/set-ssh-key-github/)

When you have everything set up and working, create a github repository:
![enter image description here](http://i.imgur.com/6kkM4yu.png)

Then type:

    $ git remote add origin https://github.com/your_username/your_repository_name.git
    $ git push -u origin master

#**Step 2: Static Pages**
##**StaticPages Controller**
Generate a `StaticPages` controller for our landing page:

    $ rails generate controller StaticPages index
This will generate `StaticPages` controller with `index` action.

If we go to `app/views/static_pages/index.html.erb` we can see that rails has generated some placeholder text. Let's change it so now our `index.html.erb` looks like this:

    <div class="index_wrapper">
	  <div class="text">
	    <h1>Plannr</h1>
	    <h3>Bringing you closer to your goals each day step by step</h3>
	  </div>
	</div>

##**Styling StaticPages**
For this we will open our `Gemfile` and somewhere in the top write:

    gem 'bootstrap-sass', '~> 3.3.6'
In your terminal type

    $ bundle install
Now that we've added `bootstrap` gem we need make some changes in order for it to run correctly:
First, lets change our `application.css` to `app/assets/stylesheets/application.scss`.
Here we need to paste two lines from bootstrap documentation. Below all those comment lines type:

    ...
    @import "bootstrap-sprockets";
	@import "bootstrap";
In `app/assets/javascripts/application.js`:

    //= require jquery
    //= require bootstrap-sprockets
	...
Now we can use `bootstrap`. But before that, let's include stylesheet reset so our webpage will look the same on different browsers. 
Create `app/assets/stylesheets/normalize.css` And [paste all this code](https://necolas.github.io/normalize.css/5.0.0/normalize.css) into it.

**Note** that `normalize.css` will be automatically included in our main `application.scss` because of this line in `application.scss`:
		
    ...
    *= require_tree .
	...
	
---

Our `application.scss` now should look like this:

    ...
    @import "bootstrap-sprockets";
	@import "bootstrap";
	
	// ===*** Variabless ***===
	$grey: #D5D5D5;
	$dark-grey: #7e7e7e;
	$black: #333;
	$white: #fff;
	$green: #B6F2AA;
	$pink: #F5B5B5;
	
	// ===*** Global ***===
	html, body {
	  padding: 0;
	  margin: 0;
	  height: 100%;
	  width: 100%;
	}

	h1, h2, h3, h4, h5, p, a {
	  padding: 0;
	  margin: 0;
	}
	
	// ===*** StaticPages#index ***===
	
	.index_wrapper {
	  height: 94.7%;
	  width: 100%;
	  background-image: url("bg.jpg");
	  background-repeat: no-repeat;
	  background-size: cover;
	  background-position: center;
	
	  .text {
	    color: #fff;
	    text-align: center;
	    padding-top: 25em;
	
	    h1 {
	      font-size: 3.5em;
	      line-height: 1.8em;
	    }
	    h3 {
	      font-size: 2em;
	      line-height: 1.5em;
	    }
	  }
	  a {
	    color: #fff;
	    text-decoration: none;
	    &:hover {
	      opacity: .8;
	    }
	  }
Download [this image](http://i.imgur.com/KpCUQJT.jpg) into `app/assets/images/bg.jpg`

##**Routes**
If we start rails server

    $ rails server
    
And go to `http://localhost:3000`, rails greets us with friendly message. Let's change that so when we go to `http://localhost:3000` it shows us our `StaticPages#index` page.

Change our  `config/routes.rb` so it looks like this :

	Rails.application.routes.draw do
		root 'static_pages#index'
	end

Now if we go to `http://localhost:3000`, it should look like this:
![enter image description here](http://i.imgur.com/TF6EsBJ.jpg)
**Note**: don't worry about whitespaces if any, we will fix them later.

##**Navigation**
Let's add a simple navigation which will be shown in our all pages. 
Open `app/views/layouts/application.html.erb` and type:

    <!DOCTYPE html>
	<html>
	  <head>
		...
	  </head>
	  <body>
	  
		<!-- Navigation -->
	    <nav class="navbar navbar-default">
	      <div class="container">
	        <div class="navbar-brand">
	          <%= link_to "Plannr", root_path %>
	        </div>
	        <ul class="nav navbar-nav navbar-right">
	            <li><%= link_to "My lists", "#" %></li>
	            <li><%= link_to "Sign out", "#" %></li>
	        </ul>
	      </div>
	    </nav>
		<!-- Navigation -->
			
	    <%= yield %>
	  </body>
	</html>
It's usually a better idea to create partials so we keep our code clean and follow rails preferred **DRY** (Don't repeat yourselft) principle.
Let's create `layouts/_header.html.erb`  partial: 

    <nav class="navbar navbar-default">
	  <div class="container">
	    <div class="navbar-brand">
	      <%= link_to "Plannr", root_path %>
	    </div>
	    <ul class="nav navbar-nav navbar-right">
	        <li><%= link_to "My lists", "#" %></li>
	        <li><%= link_to "Sign out", "#" %></li>
	    </ul>
	  </div>
	</nav>

And include it in `application.html.erb`:

    <body>
	    <%= render "layouts/header" %>
	    <%= yield %>
	</body>
 
 Now if we refresh our page, we should see a navigation bar:
![enter image description here](http://i.imgur.com/dQ4c8Lo.jpg)
 **wth** is that whitespace from?!

Let's remove it and style navigation bar:

    // ===*** Navigation ***===
	.navbar {
	  a {
	    color: $black;
	  }
	  margin: 0;
	}
	// ===*** StaticPages#index ***===
	...

##**Push to git**

    $ git status
    $ git add .
    $ git commit -am "Styled and added background-image, navigation bar"
    $ git push
    
#**Step 3: Lists**
##**Scaffolding**
Generate a `list` scaffold with some basic model attributes:

    $ rails generate scaffold List content:string --skip-stylesheets
Here we used the `--skip-stylesheets` option with the scaffold to avoid generating any stylesheets given that we’ll be using Bootstrap.

Run:

    $ rails db:migrate
   
##**Styling Lists** 
Open `app/views/lists/index.html.erb` and make it look something like this:

    <div class="lists_wrapper">
	  <div id="hero" class="container">
	    <div class="lists">
	      <h1>Your lists: </h1>
	      <div id="button">
	        <%= link_to new_list_path  do %>
	          <button>New List</button>
	        <% end %>
	      </div>
	        <% @lists.each do |list| %>
	        <div class="list">
	          <div class="row">
	            <div class="col-md-8">
	              <h2><%= link_to list.content, list %></h2>
	            </div>
	            <div class="col-md-4">
	              <div class="buttons">
	                <!-- <%= link_to 'Edit', edit_list_path(list) %> -->
	                <%= link_to list, method: :delete,
	                data: { confirm: 'Are you sure?' } do  %>
	                  <i class="fa fa-remove fa-2x" aria-hidden="true"></i>
	                <% end %>
	              </div>
	            </div>
	          </div>
	        </div>
	        <% end %>
	    </div>
	  </div>
	</div>

**Note:**


	...
	# Creates a link to new list
    <%= link_to new_list_path  do %>
    ...
    # Displays all lists from database with a link to that list
    <% @lists.each do |list| %>
	    <%= link_to list.content, list %>
    <% end %>
	...
Inside `app/views/lists/show.html.erb` type:

    <div class="lists_show_wrapper">
	  <div class="container">
	    <div class="title">
	      <h1>
	        <%= @list.content %>
	        <hr>
	      </h1>
	    </div>
	
	    <div id="links">
	      <%= link_to 'Delete', list_path(@list), method: :delete, data: { confirm: "Are you sure?" } %>
	      <%= link_to 'Back', lists_path %>
	    </div>
	  </div>
	</div>
Inside `app/views/lists/new.html.erb` add:

    <div class="new_list">
	  <div class="container">
	    <h1>New List</h1>
	
	    <%= render 'form', list: @list %>
	
	    <div id="links">
	      <%= link_to 'Back', lists_path %>
	    </div>
	
	  </div>
	</div>
Tweak `app/views/lists/_form.html.erb`:

    <div id="form">
	  <%= form_for(list) do |f| %>
	    <% if list.errors.any? %>
	      <div id="error_explanation">
	        <h2><%= pluralize(list.errors.count, "error") %> prohibited this list from being saved:</h2>
	
	        <ul>
	        <% list.errors.full_messages.each do |message| %>
	          <li><%= message %></li>
	        <% end %>
	        </ul>
	      </div>
	    <% end %>
	
	    <%= f.text_field :content, placeholder: "Write title..." %>
	    <%= f.submit %>
	
	  <% end %>
	</div>




Inside `application.scss` add:

    ...
    //===*** lists#index ***===
    .lists_wrapper {
	  height: 100%;
	  background: $white;
	
	  #hero {
	    padding-top: 4em;
	    border-radius: 10px 10px 0 0;
	
	    .lists {
	      &:last-of-type {
	        padding-bottom: 4em;
	      }
	      h1 {
	        font-size: 3.5em;
	        text-align: left;
	        padding-top: .6em;
	        padding-bottom: 1em;
	      }
	
	      #button {
	        border-bottom: 3px solid $grey;
	        padding-bottom: 1em;
	
	        button {
	          background: $white;
	          border: 2px solid $grey;
	          border-radius: 15px;
	          color: $dark-grey;
	
	          &:hover {
	            opacity: .8;
	          }
	        }
	      }
	
	      .list {
	        padding: 2em 1.8em;
	        border-bottom: 3px solid $grey;
	
	        h2 {
	          font-size: 3em;
	
	          &:hover {
	            opacity: .8;
	          }
	        }
	      }
	
	      .buttons {
	        text-align: right;
	        padding-right: 1.5em;
	        padding-top: .6em;
	
	        a {
	          color: $grey;
	        }
	       }
	
	      a {
	        color: $black;
	        text-decoration: none;
	        &:hover {
	          text-decoration: none;
	          color: $black;
	        }
	      }
	    }
	  }
	}
	
	//===*** lists#show ***===
	.lists_show_wrapper {
	  .tasks {
	    padding-left: 15em;
	  }
	  .title {
	    color: $black;
	    padding-top: 4em;
	    text-align: center;
	
	    h1 {
	      text-align: center;
	      font-size: 3.5em;
	    }
	  }
	
	  .completed {
	    text-decoration: line-through;
	    opacity: .5;
	    text-emphasis: true;
	  }
	  .task {
	    line-height: 1.4em;
	    .buttons {
	      ul li{
	        display: inline-block;
	      }
	
	      a {
	        font-size: 1.5em;
	        color: $dark-grey;
	        &:hover {
	          opacity: .8;
	        }
	      }
	    }
	  }
	  #form {
	    padding-top: 3em;
	    padding-left: 15em;
	
	    input[type="text"] {
	      font-size: 1.8em;
	      width: 70%;
	      border: none;
	      border-bottom: 3px solid $grey;
	      color: $dark-grey;
	      outline: none;
	    }
	
	    input[type="submit"] {
	      background: $white;
	      border: 2px solid $grey;
	      border-radius: 15px;
	      color: $dark-grey;
	
	      &:hover {
	        opacity: .8;
	      }
	    }
	  }
	
	  #links {
	    text-align: center;
	    padding-top: 4em;
	    padding-bottom: 4em;
	    a {
	      color: $dark-grey;
	    }
	  }
	}
	
	//=== *** lists#new ***===
	.new_list {
	  h1 {
	    padding-top: 2em;
	    text-align: center;
	    font-size: 3.5em;
	  }
	  #form {
	    padding-top: 3em;
	    padding-left: 15em;
	
	    input[type="text"] {
	      font-size: 1.8em;
	      width: 70%;
	      border: none;
	      border-bottom: 3px solid $grey;
	      color: $dark-grey;
	      outline: none;
	    }
	
	    input[type="submit"] {
	      background: $white;
	      border: 2px solid $grey;
	      border-radius: 15px;
	      color: $dark-grey;
	
	      &:hover {
	        opacity: .8;
	      }
	    }
	  }
	
	  #links {
	    text-align: center;
	    padding-top: 4em;
	    padding-bottom: 4em;
	    a {
	      color: $dark-grey;
	    }
	  }
	}

Go to `www.localhost:3000/lists`
It should look like this:
![enter image description here](http://i.imgur.com/cWNsxdj.png)

Go to `www.localhost:3000/lists/new`
It should look like this:
![enter image description here](http://i.imgur.com/7NVxn4A.png)

##**Font-awesome-rails**
Let's add `gem 'font-awesome-rails', '~> 4.6', '>= 4.6.3.1'` to our `Gemfile`. This allows us to use many different icons needed for our application.
**Note**: remember to run `bundle install` and restart rails server (ctrl + c) after adding gems.

Now, go to `app/assets/stylesheets.application.scss` and import `font-awesome`:

    @import "bootstrap-sprockets";
	@import "bootstrap";
	@import "font-awesome";
	...
If we refresh our webpage, we should see "X" icons that delete lists if clicked. Remember we've done that 
by adding 

    <%= link_to list, method: :delete, data: { confirm: 'Are you sure?' } do  %>
	    <!-- Creates remove icon -->
	    i class="fa fa-remove fa-2x" aria-hidden="true"></i> 
    <% end %>



#**Step 4: Tasks**

##**Task model**
Generate `task` model:

    $ rails generate model Task content:string list:references
    $ rails db:migrate
`list:references` adds `list_id` to `tasks` table so each task will belong to a list. 
To complete this association inside `app/models/list.rb` type:

    has_many :tasks, dependent: :destroy 
Here `dependent: :destroy`  deletes all tasks associated with a list when a list is deleted.

In `app/modes/task.rb`  rails has automatically declared `belongs_to :list` when 
we typed `list:references` in our terminal.

##**Tasks Controller**

 Generate `tasks` controller:
 

    $ rails generate controller Tasks


Inside `tasks_controller.rb` type:

    class TasksController < ApplicationController
	    before_action :set_up_list
		before_action :set_up_task, except: [:create]
		
	    def create
		    # Creates a task on current list
		    @task = @list.tasks.create(task_params)
		    
		    # Redirects to current list
		    redirect_to @list
	    end

		private

		def set_up_list
			# Finds a list you're on 
		    @list = List.find(params[:list_id])
		end
		
		def set_up_task
			# Finds task
			@task = @list.tasks.find(params[:id])
		end

		def task_params
			# Rails required strong parameters
			params.require(:task).permit(:content)
		end
	end

**Note**: `before_action`  helper runs defined private methods before any other action is ran.

##**Routes**
Now that we've set up actions needed, we need to define routes for `tasks`.
We would do that with a simple line: `resources :tasks`, but in this case, we need to use nested routing.

Modify `config/routes.rb` :

    resources :lists do
	    resources :tasks
    end
**Note**: read more about nested routes [here](http://guides.rubyonrails.org/routing.html#nested-resources).

##**Task Views**
Our tasks needs to be shown inside a list, so we add:

        <div class="tasks"><%= render @list.tasks %></div>
	    <br>
	    <div id="form">
	      <%= render "tasks/form" %>
	    </div>
	    
`<div class="tasks"><%= render @list.tasks %></div>` will render all tasks associated with a list we're currently on using `task` partial that we will define in a moment.

And

	<div id="form">
		<%= render "tasks/form" %>
	</div>
will render a `form` partial.

Our `app/views/lists/show.html.erb` now should look like this:

    <div class="lists_show_wrapper">
	  <div class="container">
	    <div class="title">
	      <h1>
	        <%= @list.content %>
	        <hr>
	      </h1>
	    </div>
	
	    <div class="tasks"><%= render @list.tasks %></div>
	    <br>
	    <div id="form">
	      <%= render "tasks/form" %>
	    </div>
	
	    <div id="links">
	      <%= link_to 'Delete', list_path(@list), method: :delete, data: { confirm: "Are you sure?" } %>
	      <%= link_to 'Back', lists_path %>
	    </div>
	  </div>
	</div>
	
If we go to `http://localhost:3000/lists/1` or any other list, we get an error:
![enter image description here](http://i.imgur.com/2IAutRC.png)

It tells us that we are missing partial `tasks/_form` so let's define it.
Create a new file `app/views/tasks/_form.html.erb` and type:

    <%= form_for ([@list, @list.tasks.build]) do |f| %>
	  <%= f.text_field :content, placeholder: "Write task..." %>
	  <%= f.submit %>
	<% end %>
Let's refresh the webpage and now we should see a form.
Try typing something and click "Create Task". Nothing happens.

In order to see tasks we create, we need to create `task` partial:
Create: `app/views/tasks/_task.html.erb` and type:

    <div class="row">
	    <div class="col-md-8">
	      <h3><%= task.content %></h3>
	    </div>
	
	    <div class="col-md-4">
	      <div class="buttons">
	        <ul>
	          <li>
	            <div class="delete">
	              <%= link_to list_task_path(@list, task.id), method: :delete do %>
	                <i class="fa fa-trash-o" aria-hidden="true"></i>
	              <% end %>
	            </div>
	          </li>
	        </ul>
	      </div>
	    </div>
	  </div>
	</div>
	
If we refresh the page we should see tasks that we've created:
![enter image description here](http://i.imgur.com/O7pPdJg.png)

**Note**: At the moment the site looks ugly and broken. Don't worry, we'll fix that soon.
The most important thing here are tasks.

##**Destroy Action**
Try clicking on the trash can icon. We get "unknown action" error.
Rails even tells us:  "The action 'destroy' could not be found for TasksController". 

 Let's open `tasks_controller.rb` and add destroy action:
 

    def create
	    ...
    end
	
	def destroy
		if @task.destroy
		    flash[:success] = "Task was deleted"
	    else
		    flash[:success] = "Task could not be deleted"
	    end
	    
	    redirect_to @list
	end

Refresh the page and try clicking on the trash can icon. It should delete the task.
 
##**Complete Action**
Creating a `complete` action will be a little bit trickier.
First, open terminal and generate migration:

    $ rails generate migration add_completed_at_to_tasks completed_at:datetime
    $ rails db:migrate
Now, open `tasks_controller.rb` and add complete action under below `destroy` but above `private`:

    def complete
	    @task.update_attribute(:completed_at, Time.now)
	    redirect_to @list, notice: "Task completed!"
    end

 Having added complete action, `app/views/tasks/_task.html.erb` should look like this:
 

    <div class="task">
	  <div class="row">
	    <div class="col-md-8">
	      <% if task.completed? %> # Helper method
	        <div class="completed"><h3><%= task.content %></h3></div>
	      <% else %>
	        <h3><%= task.content %></h3>
	      <% end %>
	    </div>
	
	    <div class="col-md-4">
	      <div class="buttons">
	        <ul>
	          <% unless task.completed? %>
	            <li>
	              <%= link_to complete_list_task_path(@list, task.id),
	              method: :patch do %>
	                <i class="fa fa-check" aria-hidden="true"></i>
	              <% end %>
	            </li>
	          <% end %>
	          <li>
	            <div class="delete">
	              <%= link_to list_task_path(@list, task.id), method: :delete do %>
	                <i class="fa fa-trash-o" aria-hidden="true"></i>
	              <% end %>
	            </div>
	          </li>
	        </ul>
	      </div>
	    </div>
	  </div>
	</div>

In fourth line we used `.completed?` helper. Let's define it.
Modify `app/models/task.rb` so it looks like this:

    class Task < ApplicationRecord
	  belongs_to :list
	
	  # Add validation so a task can't be empty
	  validates :content, presence: true
	
	  def completed?
	    # Returns true if completed_at is not blank
	    !completed_at.blank?
	  end
	end
The last thing to do in order for `complete` action to work is to define a route:
Modify `config/routes.rb`:

      resources :lists do
	    resources :tasks do
	      member do
	        patch :complete
	      end
	    end
	  end
**Note**: read about adding more RESTful actions [here](http://guides.rubyonrails.org/routing.html#adding-more-restful-actions).

![enter image description here](http://i.imgur.com/VwmuBPF.png)
##**What now?**

There are few things we need to add:
		

 - There is no authentication, so everyone can come to your site and spam it.
 - We need to add an authorization so only you can see/delete your lists and tasks.
 - Links in navigation don't work.
 - We need to add alerts and notices so we get informed about items being deleted or created.

 Let's start :)
 
 ---
#**Step 5: Authentication & Authorization**
##**Adding Devise Gem**

Firstly, let's commit the changes we made and push them to github repo:

    $ git add .
    $ git commit -am "Add list CRUDability & task actions"
    $ git push
Create new git branch for user authentication:

    $ git checkout -b devise
Open `Gemfile` and add `gem 'devise'` in the top.
Run `bundle install` in terminal and restart rails server (ctrl + c)

##**Generating User Model**
If you follow devise doccumentation [here](https://github.com/plataformatec/devise) it tells us to do few things:

    $ rails generate devise:install
    $ rails generate devise:views
    $ rails generate devise User
    $ rails db:migrate
We need to add association between user and list so that each list will belong to user. 
To do that we need to run migration:

    $ rails generate migration add_user_to_lists user:references
    $ rails db:migrate
Inside `list.rb` add:

    ...
    belongs_to :user
Inside `user.rb` add:

    ...
    has_many :lists
Go to `http://localhost:3000/lists/` and delete all lists that you've created, because they currently have no user associated with them.

Open `controllers/lists_controller.rb`. Remember it was automatically generated when we generated scaffold, but now we need to tweak it:

    class ListsController < ApplicationController
	  before_action :set_list, only: [:show, :edit, :update, :destroy]
		
	  # Users need to be logged in before any action
	  before_action :authenticate_user!
	
	
	  # GET /lists
	  # GET /lists.json
	  def index
	    @lists = List.all
	  end
	
	  # GET /lists/1
	  # GET /lists/1.json
	  def show
	  end
	
	  # GET /lists/new
	  def new
	    @list = List.new
	  end
	
	  # GET /lists/1/edit
	  def edit
	  end
	
	  # POST /lists
	  # POST /lists.json
	  def create
	    @list = current_user.lists.build(list_params)
	
	    respond_to do |format|
	      if @list.save
	        format.html { redirect_to @list, notice: 'List was successfully created.' }
	        format.json { render :show, status: :created, location: @list }
	      else
	        format.html { render :new }
	        format.json { render json: @list.errors, status: :unprocessable_entity }
	      end
	    end
	  end
	
	  # PATCH/PUT /lists/1
	  # PATCH/PUT /lists/1.json
	  def update
	    respond_to do |format|
	      if @list.update(list_params)
	        format.html { redirect_to @list, notice: 'List was successfully updated.' }
	        format.json { render :show, status: :ok, location: @list }
	      else
	        format.html { render :edit }
	        format.json { render json: @list.errors, status: :unprocessable_entity }
	      end
	    end
	  end
	
	  # DELETE /lists/1
	  # DELETE /lists/1.json
	  def destroy
	    @list.destroy
	    respond_to do |format|
	      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
	      format.json { head :no_content }
	    end
	  end
	
	  private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_list
	      @list = List.find(params[:id])
	    end
	
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def list_params
	      params.require(:list).permit(:content)
	    end
	end

Here we added two things:
1. On the fourth line we added `before_action :authenticate_user!` 
that asks users to log in before any action.
2. In action `create` we use `@list = current_user.lists.build(list_params)`
that creates new list associated with user. `current_user` is devise helper method that we generated.

If you refresh your website it should ask you to log in. Create an account and you will be redirected to `/lists` path

Go to `tasks_controller.rb` and also add: `  before_action :authenticate_user!`
 
In `app/views/lists/index.html.erb` change

    <% @lists.each do |list| %>
    # to
    <% current_user.lists.each do |list| %>

   So that the user will only see his lists he has created.
   

##**Adding Authorization**
We added authentication, but now everyone who has a link to your list can create new tasks or delete them. 
We need to add authorization so only you will be able to interact with your lists and tasks.
Open `controllers/lists_controller.rb`  add `before_action` and define private method:

    ...
    before_action :authorize_user, only: [:show, :edit, :update, :destroy]
    ...
    private
    
    ...
    def authorize_user
      unless current_user == @list.user
        redirect_to lists_path
        flash["alert"] = "You don't have permission!"
      end
    end
If you recall, registration and log in forms looked terrible.

Inside `app/views/devise/sessions/new` just copy and paste this:

    <div class="devise">
	  <div class="container">
	    <h2>Log in</h2>
	
	    <%= form_for(resource, as: resource_name, url: session_path(resource_name)) do |f| %>
	      <div class="field">
	        <%= f.email_field :email, autofocus: true, placeholder: "Email" %>
	      </div>
	
	      <div class="field">
	        <%= f.password_field :password,
	        autocomplete: "off", placeholder: "Password" %>
	      </div>
	
	      <% if devise_mapping.rememberable? -%>
	        <div class="field">
	          <%= f.check_box :remember_me %>
	          <%= f.label :remember_me %>
	        </div>
	      <% end -%>
	
	      <div class="actions">
	        <%= f.submit "Log in" %>
	      </div>
	    <% end %>
	
	    <%= render "devise/shared/links" %>
	  </div>
	</div>

And in `app/views/devise/registrations/new`:

    <div class="devise">
	  <div class="container">
	    <h2>Sign up</h2>
	    <hr>
	    <%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
	      <%= devise_error_messages! %>
	
	      <div class="field">
	        <%= f.email_field :email, autofocus: true, placeholder: "Email" %>
	      </div>
	
	      <div class="field">
	        <% if @minimum_password_length %>
	        <span><em>(<%= @minimum_password_length %> characters minimum)</em></span>
	        <% end %><br />
	        <%= f.password_field :password, autocomplete: "off", placeholder: "Password" %>
	      </div>
	
	      <div class="field">
	        <%= f.password_field :password_confirmation, autocomplete: "off", placeholder: "Password confirmation" %>
	      </div>
	
	      <div class="actions">
	        <%= f.submit "Sign up" %>
	      </div>
	    <% end %>
	
	    <%= render "devise/shared/links" %>
	  </div>
	</div>

Also add css to `app/assets/stylesheets.application.scss`:

    ...
    //===*** Devise forms ***===

	.devise {
	  h2 {
	    text-align: center;
	    padding-top: 2em;
	  }
	
	  .field {
	    padding-bottom: 2em;
	    input[type="email"], input[type="password"] {
	      font-size: 1.8em;
	      width: 100%;
	      border: none;
	      border-bottom: 3px solid $grey;
	      color: $dark-grey;
	      outline: none;
	    }
	  }
	  input[type="submit"] {
	    background: $white;
	    border: 2px solid $grey;
	    border-radius: 15px;
	    color: $dark-grey;
	
	    &:hover {
	      opacity: .8;
	    }
	  }
	  a {
	    color: $dark-grey;
	  }
	}

It should look something like this:
![enter image description here](http://i.imgur.com/t9h685H.png)

Having done that let's commit changes, merge branches and push it to [github repo](https://github.com/simposk/planner):

    $ git add .
    $ git commit -am "Add authentication and authorization"
    $ git checkout master
    $ git merge devise
    $ git push

#**Step 7: Add Links To Navigation**

Open `app/views/layouts/_header.html.erb` partial and add:

    ...
    <div class="navbar-brand">
      <%= link_to "Plannr", root_path %>
    </div>
    <ul class="nav navbar-nav navbar-right">
      <% if user_signed_in?%>
        <li><%= link_to "My lists", lists_path %></li>
        <li><%= link_to "Sign out", destroy_user_session_path, method: :delete %></li>
      <% else %>
        <li><%= link_to "Sign in", new_user_session_path %></li>
        <li><%= link_to "Sign up", new_user_registration_path %></li>
      <% end %>
    </ul>

If user is signed in, navigation shows two links to his lists and a link to sign out.
Else it shows two links, one for registration and the other one for log in.

#**Step 8:  Alerts and Notices**
Let's create a partial for all alerts and notices inside `app/views/layouts/_alert.html.erb`:

    <% if notice %>
	  <p id="notice"><%= notice %></p>
	<% elsif alert %>
	  <p id="alert"><%= alert %></p>
	<% end %>

And include this partial inside `app/views/layouts/application.html.erb`:

    <%= render "layouts/header" %>
    <%= render "layouts/alert" %>
    <%= yield %>
So now that we have that running, let's add some styling:

    ...
    //===*** Alerts & Notices***===
	#alert {
	  color: red;
	  text-align: center;
	  padding: 1em 0;
	  background: $pink;
	}
	
	#notice {
	  color: green;
	  text-align: center;
	  padding: 1em 0;
	  background: $green;
	}

#**Step 9: Deploying on Heroku**
If you don't already have an heroku account, [create it](https://www.heroku.com/).
Follow the documentation they provide how to set up heroku from terminal [here](https://devcenter.heroku.com/articles/getting-started-with-ruby#set-up).

In order for our website to run correctly, we need to add a PostgreSQL, because that's what heroku uses.
Inside `Gemfile`:
Find `gem 'sqlite3'` that rails automatically included and move it to a `group :development`.
It should look like this:

    group :development do
	  gem 'web-console'
	  gem 'listen', '~> 3.0.5'
	  ...	 
      gem 'sqlite3'
    end
Down below add:

    group :production do
	    gem 'pg'
    end
Let's commit the changes to your git repository, because if you want to deploy your app on heroku, it needs to be in git first:

    $ bundle install
    $ git add .
    $ git commit -am "Add links to navigation & styled flash messages"
    $ git push
Now we can deploy to heroku:
		
    $ heroku create
    $ git push heroku master
    $ heroku run rake db:migrate
	$ heroku open
We've deployed our website to heroku, but the background image still doesn't show up.
To fix that inside `config/environments/production.rb`:
Change `config.assets.compile` from `false` to `true`,
Add `config.assets.digest = true`.
Commit changes to git repo and deploy to heroku again.

#**Summary**
Congratulations, you've built your own personal todo planner web application! Make sure to experiment and make tweaks and changes, try to break it and then fix it again. 

Here is the [finished website](https://immense-beyond-84362.herokuapp.com/)
Here is git [repo](https://github.com/simposk/planner)
If you have any questions, you can email me at simposk@gmail.com
