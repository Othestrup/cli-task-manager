# Add, Update, and Delete tasks
# Mark a task as in progress or done
# List all tasks
# List all tasks that are done
# List all tasks that are not done
# List all tasks that are in progress
# Each task should have an id, description, status, createdAt, and updatedAt.


# Retrieve the command and arguments from the command line

require 'json'

# Define the file name where tasks will be stored.
FILE_NAME = 'tasks.json'

# Load tasks from the JSON file
def load_tasks
  if File.exist?(FILE_NAME)
    file_content = File.read(FILE_NAME)
    begin
      tasks = JSON.parse(file_content)
    rescue JSON::ParserError => e
      puts "Error parsing JSON file: #{e.message}"
      tasks = []
    end
  else
    tasks = []
    save_tasks(tasks)  # Create the file with an empty array of tasks
  end
  tasks
end

# Save tasks to the JSON file
def save_tasks(tasks)
  File.write(FILE_NAME, JSON.pretty_generate(tasks))
end

# Add a new task to the tasks list
def add_task(description)
  tasks = load_tasks

  # Generate a new unique ID:
  new_id = tasks.empty? ? 1 : tasks.map { |task| task["id"] }.max + 1

  # Get current timestamp
  timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")

  # Create a new task hash
  new_task = {
    "id" => new_id,
    "description" => description,
    "status" => "todo",
    "createdAt" => timestamp,
    "updatedAt" => timestamp
  }

  # Add the new task and save
  tasks << new_task
  save_tasks(tasks)

  puts "Task added successfully (ID: #{new_id})"
end

# Command-line argument processing
command = ARGV[0]
arguments = ARGV[1..-1] || []

case command
when "add"
  description = arguments.join(" ")
  add_task(description)
when "update"
  id = arguments[0]
  new_description = arguments[1..-1].join(" ")
  puts "Updating task #{id} to: #{new_description}"
  # Implement update functionality later
when "delete"
  id = arguments[0]
  puts "Deleting task with ID: #{id}"
  # Implement delete functionality later
when "mark-in-progress"
  id = arguments[0]
  puts "Marking task #{id} as in progress"
  # Implement marking functionality later
when "mark-done"
  id = arguments[0]
  puts "Marking task #{id} as done"
  # Implement marking functionality later
when "list"
  filter = arguments[0]
  if filter
    puts "Listing tasks with status: #{filter}"
  else
    puts "Listing all tasks"
  end
  # Implement list functionality later
else
  puts "Unknown command. Available commands are: add, update, delete, mark-in-progress, mark-done, list"
end

# Testing our methods
tasks = load_tasks
puts "Loaded tasks: #{tasks}"


# ARGV is an array that contains the arguments passed to the script
command = ARGV[0]
arguments = ARGV[1..-1] || []

# Basic command dispatcher
case command
when "add"
  description = arguments.join(" ")  # Joins all arguments into one string
  puts "Adding task: #{description}"
  # Here we'll later call a method to add the task to our JSON file
when "update"
  # Expecting the first argument to be the task ID and the rest to be the new description
  id = arguments[0]
  new_description = arguments[1..-1].join(" ")
  puts "Updating task #{id} to: #{new_description}"
  # Later, we'll update the task in our JSON file
when "delete"
  id = arguments[0]
  puts "Deleting task with ID: #{id}"
  # Later, we'll remove the task from our JSON file
when "mark-in-progress"
  id = arguments[0]
  puts "Marking task #{id} as in progress"
  # Later, we'll update the task's status
when "mark-done"
  id = arguments[0]
  puts "Marking task #{id} as done"
  # Later, we'll update the task's status
when "list"
  # Check if a status filter is provided (e.g., "done", "to-do", "in-progress")
  filter = arguments[0]
  if filter
    puts "Listing tasks with status: #{filter}"
  else
    puts "Listing all tasks"
  end
  # Later, we'll read and filter tasks from our JSON file
else
  puts "Unknown command. Available commands are: add, update, delete, mark-in-progress, mark-done, list"
end
