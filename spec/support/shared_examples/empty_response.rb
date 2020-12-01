# frozen_string_literal: true

RSpec.shared_examples 'empty response' do
  it 'return no elements' do
    subject
    expect(JSON.parse(response.body)).to be_empty
  end
end
