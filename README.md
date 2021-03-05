## Instructions

### Setting up
With RubyGems intalled on your machine, run:
- `$ gem install bundler`
- `$ bundle install`

### Running the main script
Execute the main script along with the instruction file as argument.
An instruction file can be found at 'test/fixture/command.txt'. Ex:
- `$ bundle exec ruby main.rb test/fixture/command.txt`

### Running tests
- `$ rake test:unit`
- `$ rake test:integration`
