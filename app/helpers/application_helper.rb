module ApplicationHelper
    def avatar_url(user)
        if user.avatar.attached?
            url_for(user.avatar)
        elsif user.image?
            user.image
        else
            ActionController::Base.helpers.asset_path('icon_default_avatar.png')
        end
    end

    def fixture_cover(fixture)
        if fixture.photos.attached?
            url_for(fixture.photos[0])
        else
            ActionController::Base.helpers.asset_path('icon_default_image.png')
        end
    end
end