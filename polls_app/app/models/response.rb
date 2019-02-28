# == Schema Information
#
# Table name: responses
#
#  id               :bigint(8)        not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord
    validates :user_id, presence: true
    validates :answer_choice_id, presence: true
    validates :not_duplicate_response

    belongs_to :answer_choice, 
        primary_key: :id, 
        foreign_key: :answer_choice_id,
        class_name: "AnswerChoice"

    belongs_to :respondent,
        primary_key: :id, 
        foreign_key: :user_id, 
        class_name: "User" 

    has_one :question,
        through: :answer_choice, 
        source: :question 

    def sibling_responses 
        self.question.responses.where('responses.id != (?)', self.id)
    end

    def respondent_already_answered?
        s_responses = sibling_responses
        return true if s_responses.where('responses.user_id = (?)', self.user_id).count > 0
        false
    end

    def not_duplicate_response
        if respondent_already_answered?
            errors[:base] << 'The respondent has answered it already!'
        end
    end

    def author_cant_respond
        if self.question.poll.author = self.user_id
            errors[:base] << 'Author cant response!'
        end
    end
end
