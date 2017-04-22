require 'sinatra'
require_relative "hangman.rb"
enable :sessions


get '/' do
	erb :index 
end

post '/player_names' do 
	player1 = params[:player1]
	player2 = params[:player2]
	"player 1 is #{player1} and player 2 is #{player2}"
	
	redirect '/password?player1=' + player1 + '&player2=' + player2
end


get '/password' do
	player1 = params[:player1]
	player2 = params[:player2]
	erb:password, locals: {p1_name: player1, p2_name: player2}

end

post '/secretword' do
	password = params[:word]
	session[:game] = Hangman.new(password)
	player1 = params[:player1]
	player2 = params[:player2]
	
	redirect '/guessing'

end

get '/guessing' do
	player1 = params[:player1] 
	player2 = params[:player2]
	erb:guessing, locals: {message: " Pick A Letter! ", p1_name: player1,message2: " ", p2_name: player2,counter: session[:game].counter, blank: session[:game].correct_blank.join(" "), array: session[:game].guessed }
end


post '/guess' do
	choice = params[:letter].upcase
	player1 = params[:player1] 
	player2 = params[:player2]
		
		
			
		if session[:game].available_guess(choice)
			true
			session[:game].update_guessed(choice)	
			session[:game].make_move(choice)
			
			if session[:game].winner == true
			redirect '/winner'

			elsif 
			
			session[:game].loser == true
			redirect '/loser'
			end
			
			
			redirect '/guessing?player1=' + player1 + '&player2=' + player2
		else
			
			erb:guessing, locals: {message: " ",message2: "Already Guessed", counter: session[:game].counter, p1_name: player1, p2_name: player2, blank: session[:game].correct_blank.join(" "), array: session[:game].guessed }
		end
end
get '/loser' do
	erb :losing, layout: :losing, locals: {word: session[:game].name}
end
post '/play_again' do
	redirect '/'
end
get '/winner' do
	erb :winner, layout: :winner, locals: {word: session[:game].name}
end
