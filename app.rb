require_relative 'cookbook'
require_relative 'controller'
require_relative 'router'
require_relative 'recipe'

csv_file_path = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file_path)
controller = Controller.new(cookbook)
router = Router.new(controller)

router.run
