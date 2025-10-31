module ListsHelper
  def bible_search_url(query)
    "https://bible.ru/search/?s=#{ERB::Util.url_encode(query)}"
  end

  def yandex_search_url(query)
    "https://yandex.ru/video/search/?text=#{ERB::Util.url_encode(query)}"
  end

  def rutube_search_url(query)
    "https://rutube.ru/u/ekzeget/search?channelSearchQuery=#{ERB::Util.url_encode(query)}"
  end

  def current_page_param
    params[:page] || cookies[:lists_page] || 1
  end
end