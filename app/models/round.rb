class Round < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :deck
  has_many    :guesses
  has_many    :cards, through: :deck

  #returns array of cards that are still able to be played (never answered correctly)
  def cards_to_play
    # remove_card = self.guesses.find_by(true_or_false: true)
    correct_answers = self.guesses.where(true_or_false: true)
    @correctly_answered_cards = correct_answers.map{ |guess| guess.card }
    all_cards = self.cards
    all_cards - @correctly_answered_cards
  end

  # return true if no more cards to play
  def no_more_cards?
    self.cards_to_play.empty?
  end

  def get_next_card
    cards_to_play.sample
  end


  def calc_points_for_round
    initial_points = (self.guesses.where(true_or_false: true)).count * 2
    guess_penalty = (self.guesses.where(true_or_false: false)).count
    total_round_score = initial_points - guess_penalty
  end

end

