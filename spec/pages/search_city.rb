class SearchCityPage
  include PageObject

  page_url 'http://localhost:9000/'

  #image(:seis_logo, id: )

  link(:home, class: 'active')

  text_field(:search_bar, id: 'seachbox')
  button(:search_button, id: 'searchBtn')
  button(:around_me_button, id: 'aroundMeBtn')
end
