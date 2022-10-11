require 'unicode_utils/upcase'

class Game
  # Сокращенный способ записать сеттеры для получения информации об игре
  attr_reader :letters, :errors, :good_letters, :bad_letters, :status

  # Сокращенный способ записать и сеттер и геттер для поля version
  attr_accessor :version

  #Константа количества ошибок
  MAX_ERRORS = 7

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    # Поле @status наглядно показывает статус игры
    #
    # :in_progress — игра продолжается
    # :won — игра выиграна
    # :lost — игра проиграна
    @status = :in_progress
  end

  def lost?
    @status == :lost
  end

  def won?
    @status == :won
  end

  def in_progress?
    @status == :in_progress
  end
  def solved?
    (@letters - @good_letters).empty?
  end

  def repeat?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def get_letters(slovo)
    if slovo.nil? || slovo == ''
      abort 'Задано пустое слово, не о чем играть. Закрываемся.'
    else
      slovo = slovo.encode('UTF-8')
    end

    return UnicodeUtils.upcase(slovo).split('')
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ""

    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(letter)
  end

  def add_letter_to(letters, letter)
    # Обратите внимание, что переменная - это только ярлык,
    # не смотря на то, что letters после работы метода исчезнет,
    # объект, который мы поменяли, останется
    letters << letter

    case letter
    when 'И' then letters << 'Й'
    when 'Й' then letters << 'И'
    when 'Е' then letters << 'Ё'
    when 'Ё' then letters << 'Е'
    end
  end

  def good?(letters, letter)
    @letters.include?(letter) ||
      (letter == 'Е' && @letters.include?('Ё')) ||
      (letter == 'Ё' && @letters.include?('Е')) ||
      (letter == 'И' && @letters.include?('Й')) ||
      (letter == 'Й' && @letters.include?('И'))
  end

  def next_step(letter)
    letter = UnicodeUtils.upcase(letter)

    return if repeat?(letter)

    if good?(@letters, letter)
      add_letter_to(@good_letters, letter)
    else
      add_letter_to(@bad_letters, letter)
      @errors += 1
    end

    @status = :won if solved?
    @status = :lost if MAX_ERRORS <= @errors

  end

end