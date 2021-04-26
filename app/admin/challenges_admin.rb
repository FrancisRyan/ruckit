Trestle.resource(:challenges) do
   remove_action :new
  #remove_action :destroy

  menu do
    item :challenges, icon: "fa fa-address-card"
  end

  table do
    column :title
    column :status
    column :challenger_name
     column :creator_name
    column :created_at, align: :center
    actions do |toolbar, instance, admin|
      toolbar.link 'Activate', admin.path(:activate, id: instance.id), method: :post, class: 'btn btn-success'
      toolbar.link 'Deactivate', admin.path(:deactivate, id: instance.id), method: :post, class: 'btn btn-danger'

	end
  end

  controller do
    def activate
      challenger= admin.find_instance(params)
    challenger.update(active: true)

      flash[:message] = "Fixture is activated"
      redirect_to admin.path(:show, id: challenger)
    end

    def deactivate
     challenger = admin.find_instance(params)
     challenger.update(active: false)

      flash[:message] = "Fixture is deactivated"
      redirect_to admin.path(:show, id: challenger)
    end
	  
end
  routes do
    post :activate, on: :member
    post :deactivate, on: :member
	
  end

  form do |challenger|
    text_field :title
    editor :note
     select :category_id, Category.where(active: true)
  end

end
  
  


