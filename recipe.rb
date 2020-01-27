class Recipe
  attr_reader :name, :description, :prep_time, :difficulty, :url, :content
  def initialize(details = {})
    @name = details[:name]
    @description = details[:description]
    @prep_time = details[:prep_time]
    @difficulty = details[:difficulty]
    @content = details[:content]
    @url = details[:url]
    @made = details[:made]
  end

  def made?
    @made
  end

  def mark_as_made
    @made = !@made
  end

  def add_content(content)
    @content = content
  end
end
