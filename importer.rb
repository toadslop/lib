require 'open-uri'
require 'nokogiri'

class Importer
  def initialize
    @site_list = { BBC:
      {
        query: 'https://www.bbcgoodfood.com/search/recipes?query=',
        access: 'https://www.bbcgoodfood.com'
      } }
  end

  def import_recipe_query(keyword)
    site_url = @site_list[:BBC][:query] + keyword
    html_file = open(site_url).read
    site_data = Nokogiri::HTML(html_file)
    build_query_data_hash(site_data)
  end

  def build_query_data_hash(site_data)
    site_data.search(".node-recipe").map do |element|
      {
        name: element.search('.teaser-item__title').text.strip,
        prep_time: element.search('.teaser-item__info-item--total-time').text.strip,
        difficulty: element.search('.teaser-item__info-item--skill-level').text.strip,
        description: element.search('.field-item').text.strip,
        url: @site_list[:BBC][:access] + element.search('.teaser-item__title a').attribute('href').value
      }
    end
  end

  def retrieve_content(recipe_url)
    content = "INGREDIENTS \n"
    html_file = open(recipe_url).read
    site_data = Nokogiri::HTML(html_file)
    content << retrieve_ingredient_list(site_data)
    content << "\n\nMETHOD\n"
    content << retrieve_method_list(site_data)
    content
  end

  def retrieve_ingredient_list(site_data)
    content = ""
    site_data.search('.ingredients-list__content p').remove
    site_data.search('.ingredients-list__content span').remove
    site_data.search('.ingredients-list__content li').each do |element|
      content << element.text.strip + "\n"
    end
    content
  end

  def retrieve_method_list(site_data)
    content = ""
    site_data.search('.method__list li').each do |element|
      content << element.text.strip + "\n\n"
    end
    content
  end
end
