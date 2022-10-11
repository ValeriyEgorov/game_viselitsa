# encoding: UTF-8

require 'rspec'

require 'game'

describe "Viselitsa" do

  it "Позитивный сценарий" do
    game = Game.new('слово')

    game.next_step('с')
    game.next_step('л')
    game.next_step('о')
    game.next_step('в')

    expect("#{game.status} #{game.letters.join("")}").to eq "won #{game.letters.join("")}"

  end

  it "Негативный сценарий" do
    game = Game.new('слово')

    game.next_step('с')
    game.next_step('л')
    game.next_step('о')
    game.next_step('о')
    game.next_step('д')
    game.next_step('д')
    game.next_step('у')
    game.next_step('р')
    game.next_step('а')
    game.next_step('е')
    game.next_step('г')
    game.next_step('ж')

    expect("#{game.status} #{game.letters.join("")}").to eq "lost #{game.letters.join("")}"
    expect(game.errors).to eq 7

  end

end