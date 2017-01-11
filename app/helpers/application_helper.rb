module ApplicationHelper
  def is_active_controller(*controller_names)
    controller_names.each do |controller_name|
      if params[:controller] == controller_name
        return "active"
      end
    end
    nil
  end

  def is_active_action(*action_names)
    action_names.each do |action_name|
      if params[:action] == action_name
        return "active"
      end
    end
    nil
  end
  
  def flash_class(type)
    case type.to_sym
    when :error, :failure, :danger     then 'danger'
    when :info                         then 'info'
    when :notice, :success             then 'success'
    when :alert, :warning              then 'warning'
    else                               type.to_s
    end
  end
end
