class View
  def display_list(recipes)
    recipes.each_with_index do |recipe, index|
      check_box = recipe.made? ? "X" : " "
      message = "#{index + 1}) [#{check_box}]"\
                " #{recipe.name} (#{recipe.prep_time}) (#{recipe.difficulty})"\
                "#{yield(recipe) if block_given?}"
      puts message
    end
  end

  def ask_recipe
    puts "What's the name of the recipe?"
    recipe_name = gets.chomp.capitalize
    puts "Whats the description?"
    description = gets.chomp
    puts "How long does it take to make?"
    prep_time = gets.chomp
    puts "How hard is it to make?"
    difficulty = gets.chomp
    puts "What are the ingredients?"
    details = { name: recipe_name, prep_time: nil, difficulty: nil, description: description }
    details
  end

  def recipe_to_remove
    puts "What recipe do you want to remove?"
    gets.chomp.to_i - 1
  end

  def display_list_with_description(recipes)
    display_list(recipes) { |recipe| "\n#{recipe.description} \n\n" }
  end

  def action_completed(action_name)
    puts "\n Recipe successfully #{action_name}."
  end

  def ask_search_keyword
    puts "Please enter a recipe search keyword."
    keyword = gets.chomp
    puts ""
    keyword
  end

  def ask_user_choice(data_array)
    puts "Please choose a recipe to save."
    data_array.each_with_index do |element, index|
      puts "#{index + 1}) #{element[:name]}"
      puts "   Prep Time: #{element[:prep_time]}"
      puts "   Difficult: #{element[:difficulty]}"
      puts "   Description: #{element[:description]}"
      puts "\n"
    end
    (gets.chomp.to_i - 1)
  end

  def ask_recipe_to_mark
    puts "What recipe do you want to mark?"
    (gets.chomp.to_i - 1)
  end

  def ask_index(command)
    puts "What recipe do you want to #{command}"
    (gets.chomp.to_i - 1)
  end

  def display_content(content)
    puts ""
    puts content
  end
end
