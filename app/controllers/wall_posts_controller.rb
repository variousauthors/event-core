class WallPostsController < ApplicationController
  # GET /wall_posts
  # GET /wall_posts.json
  def index
    #@wall_posts = WallPost.all

    @graph = Koala::Facebook::API.new('AAACEdEose0cBAMjppECtrdW2bwTalkZAE1aDpUeWL2PeOG5yD5hZAmgIVg1MlIRImBb8ZBhojkyZChgNulZCVbRlR4W3ZAe2XmouqU4LssWyBS8JZC1m4ZBW')

    profile = @graph.get_object("me")
    friends = @graph.get_connections("me", "friends")
    @wall_posts = @graph.get_connections("me", "feed").select do |wall_post|
      wall_post.has_key? "status_type"
    end

    puts 'profile: ' + profile.inspect
    puts 'friends: ' + friends.inspect

    respond_to do |format|
      format.html { render layout: false } # index.html.erb
      format.json { render json: @wall_posts }
    end
  end

  # GET /wall_posts/1
  # GET /wall_posts/1.json
  def show
    @wall_post = WallPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wall_post }
    end
  end

  # GET /wall_posts/new
  # GET /wall_posts/new.json
  def new
    @wall_post = WallPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wall_post }
    end
  end

  # GET /wall_posts/1/edit
  def edit
    @wall_post = WallPost.find(params[:id])
  end

  # POST /wall_posts
  # POST /wall_posts.json
  def create
    @wall_post = WallPost.new(params[:wall_post])

    respond_to do |format|
      if @wall_post.save
        format.html { redirect_to @wall_post, notice: 'Wall post was successfully created.' }
        format.json { render json: @wall_post, status: :created, location: @wall_post }
      else
        format.html { render action: "new" }
        format.json { render json: @wall_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wall_posts/1
  # PUT /wall_posts/1.json
  def update
    @wall_post = WallPost.find(params[:id])

    respond_to do |format|
      if @wall_post.update_attributes(params[:wall_post])
        format.html { redirect_to @wall_post, notice: 'Wall post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wall_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wall_posts/1
  # DELETE /wall_posts/1.json
  def destroy
    @wall_post = WallPost.find(params[:id])
    @wall_post.destroy

    respond_to do |format|
      format.html { redirect_to wall_posts_url }
      format.json { head :no_content }
    end
  end
end
