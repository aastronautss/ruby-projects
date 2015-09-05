require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
  	puts "Initializing..."
  	@client = JumpstartAuth.twitter
  end

  def tweet(message)
  	if message.length <= 140
  		@client.update(message)
  	else
  		puts "Your tweet is too long!"
  	end
  end

  def dm(target, message)
    puts "Trying to send @#{target} this direct message:"
    puts message

    screen_names = followers_list

    if screen_names.include?(target)
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "Cannot send a direct message: @#{target} is not following you!"
    end
  end

  def spam_my_followers(message)
    list = followers_list
    list.each { |follower| dm(follower, message) }
  end

  def everyones_last_tweet
    friends = @client.friends
    friends.each do |friend|
      screen_name = friend.screen_name
      last_tweet = friend.status.text
      puts "@#{screen_name} said:\n#{last_tweet}\n\n"
    end
  end

  def followers_list
    @client.followers.collect { |follower| @client.user(follower).screen_name }
  end

  def run
  	puts "Welcome to the JSL Twitter Client!"

  	command = ""
  	while command != "q"
  		printf "enter command: "
  		input = gets.chomp
  		parts = input.split(" ")
  		command = parts[0]

  		case command
  		when "q" then puts "Goodbye!"
  		when "t" then tweet(parts[1..-1].join(" "))
		  when 'dm' then dm(parts[1], parts[2..-1].join(" "))
      when 'spam' then spam_my_followers(parts[1..-1].join(" "))
      when 'status' then everyones_last_tweet
  		else
  			puts "Sorry, I don't know how to #{command}"
  		end
  	end
  end
end

blogger = MicroBlogger.new
blogger.run
