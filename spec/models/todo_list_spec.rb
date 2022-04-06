# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoList, type: :model do
  subject(:todo_list) { build(:todo_list) }

  it { expect(described_class.routines.keys).to eq %w[once daily weekly monthly] }

  it 'sets default routine to once' do
    expect(todo_list.routine).to eq 'once'
  end

  it 'is valid with a title' do
    expect(todo_list.valid?).to be true

    todo_list.title = nil
    expect(todo_list.valid?).to be false
    expect(todo_list.errors[:title]).to(
      eq Array(I18n.t('activerecord.errors.models.todo_list.attributes.title.blank'))
    )
  end

  it 'is valid with a user' do
    expect(todo_list.valid?).to be true

    todo_list.user = nil
    expect(todo_list.valid?).to be false
  end

  it 'is valid with a defined routine' do
    todo_list.routine = :once
    expect(todo_list.valid?).to be true
    todo_list.routine = :daily
    expect(todo_list.valid?).to be true
    todo_list.routine = :weekly
    expect(todo_list.valid?).to be true
    todo_list.routine = :monthly
    expect(todo_list.valid?).to be true

    expect { todo_list.routine = :invalid }.to raise_error ArgumentError
  end

  describe '#destroy' do
    it 'updates completed_at' do
      todo_list.save
      expect(todo_list.completed_at).to be_nil

      todo_list.destroy
      expect(todo_list.completed_at).not_to be_nil
      expect(todo_list.completed_at).to be_a Time
    end
  end
end
