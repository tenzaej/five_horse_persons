class Round < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :deck
  has_many    :guesses
  has_many    :cards, through: :guesses

  #returns array of cards that are still able to be played (never answered correctly)
  def cards_to_play
    # remove_card = self.guesses.find_by(true_or_false: true)
    correct_answers = self.guesses.where(true_or_false: true)
    correctly_answered_cards = correct_answers.select{ |guess| guess.card }
    all_cards = self.cards
    all_cards - correctly_answered_cards
  end

  def get_next_card
    cards_to_play.first
  end

end

