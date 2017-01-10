module ApplicationHelper
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
