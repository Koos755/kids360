module ParentsHelper
  def click_to_add(child)
    link_to '<i class="icon-plus-sign-alt"></i><click to>'.html_safe, new_authorization_url(child: child)
  end
end
