require "Minitest/autorun"
require_relative "hangman.rb"

class Testhangmanfunctions < Minitest::Test

	def text_class_returns_upcased_word
		hangman = Hangman.new("HaNGmaN")
		assert_equal("HANGMAN",hangman.name)
	end


	def text_class_returns_name
		hangman = Hangman.new("Kenny")
		assert_equal(5,hangman.charcount)
	end

	def text_class_returns_five_blanks
		hangman = Hangman.new("Kenny")
		assert_equal(["_""_""_""_""_"],hangman.blank)
	end
	def text_class_returns_if_include_in_password
		hangman = Hangman.new("Kenny")
		letter = "e"
		assert_equal(true,hangman.correct_letter?(letter))
	end
	def text_class_user_guess_is_pushed_into_guess_array
	    hangman = Hangman.new("Kenny")
	    hangman.guessed = ["b","g","i"]
	    letter = "f"
	    assert_equal(["b","g","i","f"],hangman.update_guessed(letter))
	end    	


end