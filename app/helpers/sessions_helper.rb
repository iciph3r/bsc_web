module SessionsHelper

  # Logs in the provided user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Store current user in class variable, if exists.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  # Redirect to stored location.
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Store the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
