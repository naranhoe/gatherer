require 'rails_helper'

RSpec.describe Task do

  it_should_behave_like "sizeable"

  describe 'velocity' do
    let(:task) { Task.new(size: 3) }

    it 'does not count an incomplete task towards velocity' do
      expect(task).not_to be_part_of_velocity
      expect(task.points_towards_velocity).to eq(0)
    end

    it 'does not count a long-ago task toward velocity' do
      task.mark_completed(6.months.ago)
      expect(task).not_to be_part_of_velocity
      expect(task.points_towards_velocity).to eq(0)
    end

    it 'counts a recently completed task toward velocity' do
      task.mark_completed(1.day.ago)
      expect(task).to be_part_of_velocity
      expect(task.points_towards_velocity).to eq(3)
    end

  end
end
