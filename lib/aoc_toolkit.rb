# frozen_string_literal: true

require "active_support/all"
require "fileutils"
require_relative "aoc_toolkit/version"
require_relative "aoc_toolkit/cli"

module AocToolkit
  TIMEZONE = "Eastern Time (US & Canada)"
  QUIZ_DIR = File.join(File.dirname(__FILE__), "..", "quiz")

  class Error < StandardError; end

  class << self
    def bootstrap
      year_dir = File.join(QUIZ_DIR, year.to_s)
      FileUtils.mkdir_p(year_dir)
      days_active.map do |active_date|
        day_dir = File.join(year_dir, active_date.day.to_s.rjust(2, "0"))
        FileUtils.mkdir_p(day_dir)
      end
    end

    private

    def year
      Time.current.year
    end

    def quiz_days
      (1..25).to_a.map { |day| Date.new(year, 12, day) }
    end

    def days_active
      quiz_days.filter { |day| day <= Date.today }
    end
  end
end
