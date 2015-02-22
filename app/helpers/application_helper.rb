module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "ProjectRobin").join(" - ")
      end
    end
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end

  def authorized?(permission, thing, &block)
    block.call if can?(permission.to_sym, thing) || current_user.try(:admin?)
  end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
        concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
          concat content_tag(:span, 'Close', class: 'sr-only')
        end)
        concat message
      end)
    end
    nil
  end
end
