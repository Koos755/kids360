module ParentsHelper
  def click_to_add(child)
    link_to '<click to add>', new_authorization_url(child: child)
  end
end
