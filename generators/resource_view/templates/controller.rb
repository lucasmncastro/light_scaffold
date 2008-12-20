class <%= class_name %>Controller < ResourceView::Base
<% for action in actions -%>
  def <%= action %>
  end

<% end -%>
end
