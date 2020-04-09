#!/usr/bin/ruby
# warn_indent: true

# MorseCoder, a Morse Code Converter
# Copyright (C) 2019-2020 Toni Helminen
# GPLv3

module MorseCoder
  NAME 	      = "MorseCoder 1.01"
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

  def MorseCoder.morse msg
    result = ""
    msg.each_char do | ch |
      if ch == " "
        result += "     "
      elsif MORSE_CODES.keys.include? ch
        result += MORSE_CODES[ch] + " "
      else
        fail "Invalid Morse String: `#{msg}´"
      end
    end
    return result
  end

  def MorseCoder.text msg
    out, values = "", MORSE_CODES.values.sort { | a, b | b.length <=> a.length }
    while msg != nil and msg.length > 0
      len = msg.length
      if msg.match(/^\s{5}/)
        out += " "
        msg  = msg[5..-1]
      elsif msg.match(/^\s/)
        out += ""
        msg  = msg[1..-1]
      else
        values.each do | val |
          if msg.start_with?(val)
            msg = msg[val.length..-1]
            out += MORSE_CODES.key(val)
            break
          end
        end
        fail "Bad Morse Code: `#{msg}´" if len == msg.length
      end
    end
    return out
  end

  def MorseCoder.version
    "#{MorseCoder::NAME}"
  end

  def MorseCoder.help
    puts "# Help MorseCoder"
    puts "Usage: > MorseCoder.rb [OPT]?"
    puts ""
    puts "## Options"
    puts "help        This Help"
    puts "version     Show version"
    puts "tests       Unittests"
    puts "examples    Examples"
    puts "morse [STR] Morse code -> Text"
    puts "text [STR]  Text -> Morse code"
  end

  def MorseCoder.one_case str
    morse = MorseCoder.morse(str)
    fail	   if MorseCoder.text(morse) != str
  end

  def MorseCoder.unit_tests
    MorseCoder.one_case "hello"
    MorseCoder.one_case "hello world"
    MorseCoder.one_case "qwerty"
    puts "OK"
  end

  def MorseCoder.examples
    puts "# Examples"
    str = "hello world"
    puts "1: '#{str}' => '#{MorseCoder.morse(str)}'"
    str = "morse code examples"
    puts "2: '#{str}' => '#{MorseCoder.morse(str)}'"
    str = ".... . .-.. .-.. ---      .-- --- .-. .-.. -.. "
    puts "3: '#{str}' => '#{MorseCoder.text(str)}'"
  end

  def MorseCoder.main
    len = ARGV.length
    case ARGV[0]
    when "version"  then  puts MorseCoder.version
    when "examples" then  MorseCoder.examples
    when "tests"    then  MorseCoder.unit_tests
    when "help"     then  MorseCoder.help
    when "morse"    then
      str = len ? ARGV[1] : ""
      puts MorseCoder.morse(str)
    when "text"     then
      str = len ? ARGV[1] : ""
      puts MorseCoder.text(str)
    else
      MorseCoder.help
    end
  end

end

# https://stackoverflow.com/questions/582686/should-i-define-a-main-method-in-my-ruby-scripts/582694
if __FILE__ == $0
  MorseCoder.main
end
