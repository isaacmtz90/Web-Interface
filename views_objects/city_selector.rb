class City_Details

  PLACEHOLDER_IMG_URL = 'http://placehold.it/100x100?text=G'

  attr_reader :country_code, :name,

  def initialize(city_details)
    @country_code = city_details.countr_code
    @name = city_details.name
  end

  private

  def format_all_courses(courses)
    new_courses = courses&.map do |course|
      formatted_course(course)
    end
  end

  def formatted_course(course)
    short_introduction = shortened(course.introduction, SHORT_STR_SIZE)
    photo_url = course.photo_url || PLACEHOLDER_IMG_URL

    CourseView.new(
      id = course.id,
      title = course.title,
      main_introduction = short_introduction,
      resource_url = course.resource_url,
      photo_url = photo_url
    )
  end
end
