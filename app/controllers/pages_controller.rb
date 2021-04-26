class PagesController < ApplicationController
  def home
  end

  def search
    @categories = Category.all
    @category = Category.find(params[:category]) if params[:category].present?

    # @fixtures = Fixture.where("active = ? AND fixtures.title ILIKE ? AND category_id = ?", true, "%#{params[:q]}%", params[:category])

    @q = params[:q]
    @min = params[:min]
    @max = params[:max]
    @delivery = params[:location].present? ? params[:location] : "0"
    @sort = params[:sort].present? ? params[:sort] : "age asc"

    query_condition = []
    query_condition[0] = "fixtures.active = true"
    query_condition[0] += " AND ((fixtures.has_single_detailing = true AND detailings.detailing_type = 0) OR (fixtures.has_single_detailing = false))"

    if !@q.blank?
      query_condition[0] += " AND fixtures.title ILIKE ?"
      query_condition.push "%#{@q}%"
    end

    if !params[:category].blank?
      query_condition[0] += " AND category_id = ?"
      query_condition.push params[:category]
    end

    if !params[:min].blank?
      query_condition[0] += " AND detailings.age >= ?"
      query_condition.push @min
    end

    if !params[:max].blank?
      query_condition[0] += " AND detailings.age<= ?"
      query_condition.push @max
    end

    if !params[:match].blank? && params[:match] != "0"
      query_condition[0] += " AND detailings.match_time <= ?"
      query_condition.push @delivery
    end

    @fixtures = Fixture
                .select("fixtures.id, fixtures.title, fixtures.user_id, MIN(detailings.age) AS age")
                .joins(:detailings)
                .where(query_condition)
                .group("fixtures.id")
                .order(@sort)
                .page(params[:page])
                .per(6)
  end
  
  def calendar
    params[:start_date] ||= Date.current.to_s

    start_date = Date.parse(params[:start_date])
    first_of_month = (start_date - 1.month).beginning_of_month
    end_of_month = (start_date + 1.month).end_of_month

    @challenges = Challenge.where("creator_id = ? AND status = ? AND due_date BETWEEN ? AND ?", 
                          current_user.id,
                          Challenge.statuses[:inprogress],
                          first_of_month,
                          end_of_month)
  end
  
end
