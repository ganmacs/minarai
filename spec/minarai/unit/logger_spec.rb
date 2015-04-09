require 'minarai/logger'
require 'ansi/code'

describe Minarai::Logger do
  describe 'logger' do
    subject { described_class }

    describe 'output $stdout some prefix and color' do
      it { expect { described_class.info('output') }.to output(ANSI.green("INFO : output\n")).to_stdout }
    end

    %i(skip done fail warn info error fatal).each do |method|
      it "have #{method} method" do
        is_expected.to be_respond_to method
      end
    end
  end
end
