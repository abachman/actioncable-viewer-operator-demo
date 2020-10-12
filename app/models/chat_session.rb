class ChatSession < ApplicationRecord
  include AASM

  before_validation :generate_token
  belongs_to :operator, optional: true

  aasm(:viewer, column: 'viewer_state', namespace: :viewer) do
    state :pending, initial: true
    state :connected
    state :disconnected

    event :connect do
      transitions from: %i[pending disconnected connected], to: :connected
    end

    event :disconnect do
      transitions from: :connected, to: :disconnected
    end
  end

  aasm(:operator, column: 'operator_state', namespace: :operator) do
    state :pending, initial: true
    state :connected
    state :disconnected

    event :connect do
      transitions from: %i[pending disconnected connected], to: :connected
    end

    event :disconnect do
      transitions from: :connected, to: :disconnected
    end
  end

  private

  def generate_token
    self.token = TokenGenerator.generate if self.token.blank?
  end
end
