# frozen_string_literal: true

RSpec.describe AocToolkit do
  let(:time) { "02-12-1980 12:00:00 -0500" }

  around { |example| Timecop.freeze(time) { example.run } }
  after { FileUtils.rm_rf("quiz/1980") }

  it "has a version number" do
    expect(AocToolkit::VERSION).not_to be nil
  end

  it "uses EST timezone" do
    expect(AocToolkit::TIMEZONE).to eq("Eastern Time (US & Canada)")
  end

  describe "#bootstrap" do
    subject { described_class.bootstrap }

    context "by default" do
      before { subject }

      it "creates current year dir" do
        expect(Dir.exist?("quiz/1980")).to be_truthy
      end

      it "creates dirs for days that passed after beginning of December" do
        expect(Dir.exist?("quiz/1980/01")).to be_truthy
        expect(Dir.exist?("quiz/1980/02")).to be_truthy
      end

      context "after the quiz" do
        let(:time) { "31-12-1980 12:00:00 -0500" }

        it "creates only the quiz dates dirs" do
          expect(Dir.exist?("quiz/1980/25")).to be_truthy
          expect(Dir.exist?("quiz/1980/26")).to be_falsey
        end
      end
    end
  end
end
