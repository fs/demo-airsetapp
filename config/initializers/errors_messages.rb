ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  error = instance.error_message.kind_of?(Array) ? instance.error_message.join(', ') : instance.error_message
  if html_tag !~ /<label/ && html_tag !~ /type="checkbox"/ && html_tag !~ /type="hidden"/
    html = %(#{html_tag} <span class="message">#{error}</span>)
  else
    html = html_tag
  end
  %(<div class="error">#{html}</div>)
end
