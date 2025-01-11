require 'json'
require 'net/http'
require 'uri'
require 'dotenv'

Dotenv.load

GITHUB_USERNAME = 'your-username'
GITHUB_TOKEN = ENV['GITHUB_TOKEN']
CLONE_PATH = ENV['CLONE_PATH'] || './'

if GITHUB_TOKEN.nil? || GITHUB_TOKEN.empty?
  puts "Error: GitHub token is not set in the .env file."
  exit(1)
end

Dir.mkdir(CLONE_PATH) unless Dir.exist?(CLONE_PATH)

GITHUB_API_URL = "https://api.github.com/user/repos"

def fetch_repositories
  uri = URI.parse(GITHUB_API_URL)
  request = Net::HTTP::Get.new(uri)
  request.basic_auth(GITHUB_USERNAME, GITHUB_TOKEN)

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end

  unless response.code.to_i == 200
    puts "Error fetching repositories: #{response.code} - #{response.message}"
    puts response.body
    exit(1)
  end

  JSON.parse(response.body)
end

def clone_repository(repo_url, clone_path)
  system("git clone #{repo_url} #{clone_path}")
end

repositories = fetch_repositories

Dir.chdir(CLONE_PATH) do
  repositories.each do |repo|
    repo_name = repo['name']
    repo_url = repo['clone_url']
    repo_url = repo['ssh_url'] if repo['private']

    if Dir.exist?(repo_name)
      puts "Skipping #{repo_name} (already cloned)..."
      next
    end

    puts "Cloning #{repo_name} into #{CLONE_PATH}..."
    clone_repository(repo_url, repo_name)
  end
end

puts "All repositories cloned successfully!"
