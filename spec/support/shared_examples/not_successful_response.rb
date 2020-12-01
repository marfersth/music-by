# frozen_string_literal: true

RSpec.shared_examples 'not successful response' do
  specify do
    subject
    expect(response).to_not be_successful
  end
end
