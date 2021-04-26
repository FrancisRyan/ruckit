Trestle.resource(:fixtures) do
  remove_action :new
  #remove_action :destroy

  menu do
    item :fixtures, icon: "fa fa-address-card"
  end

  table do
    column :title
    column :active
    column :user, -> (obj) { obj.user.full_name }
    column :created_at, align: :center
    actions do |toolbar, instance, admin|
      toolbar.link 'Activate', admin.path(:activate, id: instance.id), method: :post, class: 'btn btn-success'
      toolbar.link 'Deactivate', admin.path(:deactivate, id: instance.id), method: :post, class: 'btn btn-danger'

	end
  end

  controller do
    def activate
      fixture = admin.find_instance(params)
      fixture.update(active: true)

      flash[:message] = "Fixture is activated"
      redirect_to admin.path(:show, id: fixture)
    end

    def deactivate
      fixture = admin.find_instance(params)
      fixture.update(active: false)

      flash[:message] = "Fixture is deactivated"
      redirect_to admin.path(:show, id: fixture)
    end
	

end
  routes do
    post :activate, on: :member
    post :deactivate, on: :member
	
  end

  form do |fixture|
    text_field :title
    editor :description
    select :category_id, Category.where(active: true)
  end

  search do |query|
    if query
      Fixture.where("title ILIKE ?", "%#{query}%")
    else
      Fixture.all
    end
  end
end