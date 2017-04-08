require 'octokit'

namespace :github do
  desc 'GitHub authentication'
  task :auth do
    begin
      Octokit.configure do |c|
        c.access_token = ENV['GITHUB_ACCESS_TOKEN']
      end

      rate_limit = Octokit.rate_limit!
      puts 'Exceeded limit of the GitHub API request' if rate_limit.remaining.zero?
    rescue => e
      puts e.message
    end
  end
end

namespace :deploy do
  desc 'Merges the develop branch into master'
  task :merge do
    sh 'git checkout master'
    sh 'git pull'
    sh 'git merge develop'
    sh 'git push'
  end

  desc 'Merges the develop branch into master and creates a release'
  task :release, [:version, :title, :body] => ['github:auth', :merge] do |_t, args|
    begin
      Octokit.create_release(
        ActiveModelSerializerHelpers::REPO,
        args.version,
        name: args.title,
        body: args.body,
        target_commitish: :master,
        draft: false,
        prerelease: false
      )
    rescue => e
      puts e.message
    end
  end
end
