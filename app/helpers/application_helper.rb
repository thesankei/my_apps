module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Njooh"
      if page_title.empty?
        base_title
      else
        "#{base_title} | #{page_title}"
      end
  end
  
  #Sets application layout depending on whether the user is Admin or Member.
  #
  #Get More Ruby'ish way of doing this.
  def user_or_admin_layout
    if has_role?(current_user, 'admin')
      "admin"
    else
      "application"
    end
  end
  
  #Checks whether current user is Admin.
  def is_user_admin?
    if has_role?(current_user, 'admin')
      true
    else
      false
    end
  end
  
  #Checks whether current user is a Member.
  def is_user_member?
    if has_role?(current_user, 'member')
      true
    else
      false
    end
  end
  
  #Checks whether the given user is the current user.
  def current_user?(user)
    user == current_user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def signed_in_user
    unless signed_in?
      #store_location
      redirect_to signin_path, notice: "Please sign in." 
    end
  end
  
  def verify_admin
    #:authenticate_user!
    redirect_to root_url unless has_role?(current_user, 'admin')
  end
  
  def flash_class(level)
    case level
      when :notice then 'info'
      when :error then 'error'
      when :alert then 'warning'
    end
  end
end
