class Project
  attr_accessor :tasks, :due_date

  def initialize
    @tasks = []
  end

  def done?
    tasks.reject(&:complete?).empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    tasks.reject(&:complete?).sum(&:size)
  end

  def completed_velocity
    tasks.sum(&:points_towards_velocity)
  end

  def current_rate
    completed_velocity * 1.0 / 21
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    (Date.today + projected_days_remaining) <= due_date
  end

end
