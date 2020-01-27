require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    load_csv
  end

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(
        name: row[0],
        prep_time: row[1],
        difficulty: row[2],
        description: row[3],
        url: row[4],
        content: row[5],
        made: row[6]
      )
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def update_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.prep_time, recipe.difficulty, recipe.description, recipe.url, recipe.content, recipe.made?] }
    end
  end
end
