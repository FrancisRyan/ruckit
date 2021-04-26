Trestle.resource(:challenges) do
  remove_action :destroy

  menu do
    item :challenges, icon: "fa fa-money", label: "Withdraw"
  end

  collection do
    Transaction.withdraw
  end

  table do
    column :challenger
    column :team
    column :status
    column :location
    column :created_at, align: :center

    actions do |toolbar, instance, admin|
      if instance.withdraw? && instance.pending?
        toolbar.link 'Approve', admin.path(:approve, id: instance.id), method: :post, class: 'btn btn-success'
        toolbar.link 'Reject', admin.path(:reject, id: instance.id), method: :post, class: 'btn btn-danger'
      end
    end
  end

  controller do
    def approve
      challenger = admin.find_instance(params)
     

      if response.success?
       
        end
     
      end
      
    end

    def reject
      
    end
  end

  routes do
    post :approve, on: :member
    post :reject, on: :member
  end
  
end
