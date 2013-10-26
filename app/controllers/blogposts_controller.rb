class BlogpostsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # Only owner of a Blogpost can delete and edit it.
  before_filter :verify_admin, only: :index
  before_filter :correct_user, only: [:update, :destroy]
  
  # GET /blogposts
  # GET /blogposts.json
  def index
    @blogposts = Blogpost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogposts }
    end
  end

  # GET /blogposts/1
  # GET /blogposts/1.json
  def show
    @blogpost = Blogpost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blogpost }
    end
  end

  # GET /blogposts/new
  # GET /blogposts/new.json
  def new
    @blogpost = Blogpost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blogpost }
    end
  end

  # GET /blogposts/1/edit
  def edit
    @blogpost = Blogpost.find(params[:id])
  end

  # POST /blogposts
  # POST /blogposts.json
  def create
    @blogpost = Blogpost.new(params[:blogpost])
    @blogpost.user_id = current_user.id

    respond_to do |format|
      if @blogpost.save
        format.html { redirect_to @blogpost, notice: 'Blogpost was successfully created.' }
        format.json { render json: @blogpost, status: :created, location: @blogpost }
      else
        format.html { render action: "new" }
        format.json { render json: @blogpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blogposts/1
  # PUT /blogposts/1.json
  def update
    @blogpost = Blogpost.find(params[:id])

    respond_to do |format|
      if @blogpost.update_attributes(params[:blogpost])
        format.html { redirect_to @blogpost, notice: 'Blogpost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blogpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogposts/1
  # DELETE /blogposts/1.json
  def destroy
    @blogpost = Blogpost.find(params[:id])
    @blogpost.destroy

    respond_to do |format|
      format.html { redirect_to blogfeed_path }
      format.json { head :no_content }
    end
  end
  
  # Displays a  user's Blog Feed.
  def blogfeed
    if params[:tag]
      @blogposts = current_user.blog_feed.tagged_with(params[:tag]).paginate(page: params[:page], :per_page => 10)
    else
      @blogposts = current_user.blog_feed.paginate(page: params[:page], :per_page => 10)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogposts }
    end
  end
  
  #Checks whether the current user actually has the id of the given blogpost.
  def correct_user
    @blogpost = current_user.blogposts.find_by_id(params[:id])
    redirect_to root_path if @blogpost.nil? #redirect to blogposts home
  end
end
