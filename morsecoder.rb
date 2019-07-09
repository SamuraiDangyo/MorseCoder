#!/usr/bin/ruby
# warn_indent: true

##
#
# MorseCoder, a Morse Code Converter
# Copyright (C) 2019 Toni Helminen ( kalleankka1@gmail.com )
#
# MorseCoder is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# MorseCoder is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##

module MorseCoder

	VERSION = "1.0"
	
	MORSE_CODES = {
		"a" => ".-",
		"b" => "-...",
		"c" => "-.-.-",
		"d" => "-..",
		"e" => ".",
		"f" => "..-.",
		"g" => "--.",
		"h" => "....",
		"i" => "..",
		"j" => ".---",
		"k" => "-.-",
		"l" => ".-..",
		"m" => "--",
		"n" => "-.",
		"o" => "---",
		"p" => ".--.",
		"q" => "--.-",
		"r" => ".-.",
		"s" => "...",
		"t" => "-",
		"u" => "..-",
		"v" => "...-",
		"w" => ".--",
		"x" => "-..-",
		"y" => "-.--",
		"z" => "--..",
		"1" => ".---",
		"2" => "..---",
		"3" => "...--",
		"4" => "....-",
		"5" => ".....",
		"6" => "-....",
		"7" => "--...",
		"8" => "---..",
		"9" => "----.",
		"0" => "-----"
	}

	def MorseCoder.tomorse msg
		out = ""
		msg.each_char do | c |
			if c == " "
				out += "     "
			elsif MORSE_CODES.keys.include? c
				out += MORSE_CODES[c]
				out += " "
			else
				fail "MorseCoder.rb Error: Invalid Morse String: `#{msg}´"
			end
		end
		return out
	end

	def MorseCoder.tostr msg
		out = ""
		v = MORSE_CODES.values.sort { |a, b| b.length <=> a.length }
		while msg != nil and msg.length > 0
			len = msg.length
			if msg.match(/^\s{5}/)
				out += " "
				msg = msg[5..-1]
			elsif msg.match(/^\s/)
				out += ""
				msg = msg[1..-1]
			else
				v.each do | val |
					if msg.start_with?(val)
						msg = msg[val.length..-1]
						out += MORSE_CODES.key(val)
						break
					end
				end
				fail "MorseCoder.rb Error: Bad Morse Code: `#{msg}´" if len == msg.length
			end
			
		end
		return out
	end
	
	def MorseCoder.name
		return "MorseCoder #{MorseCoder::VERSION}"
	end
	
	def MorseCoder.help
		puts "~~~ #{MorseCoder.name} ~~~\n"
		puts "### help() ###"
		puts "Usage: MorseCoder.rb [OPTION]... [PARAMS]..."
		puts "-help: This Help"
		puts "-tests: Run Unittests"
		puts "-examples: MorseCoder Examples"
		puts "-tomorse \"str\: Convert String To Morse Code"
		puts "-tostr \"morse\: Convert Morse Code To String"
		puts "-name: Print Name And Version"
	end
	
	def MorseCoder.one_case str
		a = MorseCoder.tomorse(str)
		b = MorseCoder.tostr(a)
		fail "MorseCoder error: #{a} <> #{b}" if b != str
		return 1
	end
	
	def MorseCoder.unit_tests
		puts "### unit_tests() ###"
		total = 0
		total += MorseCoder.one_case "hello"
		total += MorseCoder.one_case "hello world"
		total += MorseCoder.one_case "qwerty"
		puts "#{total} / #{total}"
		puts "= OK"
	end
	
	def MorseCoder.examples
		puts "### examples() ###\n\n"
		str = "hello world"
		puts "1 / str: \"#{str}\"\n-> \nmorse: \"#{MorseCoder.tomorse(str)}\"\n\n"
		str = "morse code examples"
		puts "2 / str: \"#{str}\"\n -> \nmorse: \"#{MorseCoder.tomorse(str)}\"\n\n"
		str = ".... . .-.. .-.. ---      .-- --- .-. .-.. -.. "
		puts "3 / morse: \"#{str}\"\n-> \nstr: \"#{MorseCoder.tostr(str)}\""
	end
	
	def MorseCoder.main
		i, len = 0, ARGV.length
		MorseCoder.help and return if len < 1
		while i < len
			case ARGV[i]
			when "-name" then
				puts "#{MorseCoder.name} by Toni Helminen"
			when "-examples" then
				MorseCoder.examples
			when "-tests" then
				MorseCoder.unit_tests
			when "-help" then
				MorseCoder.help
			when "-tomorse" then
				#puts "### str -> morse ###"
				str = i + 1 < len ? ARGV[i + 1] : ""
				puts "str: \"#{str}\"\n->\nmorse: \"#{MorseCoder.tomorse(str)}\""
				i += 1
			when "-tostr" then
				#puts "### morse -> str ###"
				str = i + 1 < len ? ARGV[i + 1] : ""
				puts "morse: \"#{str}\"\n->\nstr: \"#{MorseCoder.tostr(str)}\""
				i += 1
			else
				puts "Unknown Command: \"#{ARGV[i]}\""
				return
			end
			i += 1
		end
	end
	
end

# https://stackoverflow.com/questions/582686/should-i-define-a-main-method-in-my-ruby-scripts/582694
if __FILE__ == $0
	MorseCoder.main
end
