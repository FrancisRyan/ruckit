Trestle.admin(:dashboard) do
    menu do
        item :dashboard, icon: "fa fa-tachometer"
    end

    controller do 
        def index
            @user_count = User.count()
            @fixture_count = Fixture.count()
            @challenge_count = Challenge.count()
            @categories_count = Category.count()
        end
    end
end