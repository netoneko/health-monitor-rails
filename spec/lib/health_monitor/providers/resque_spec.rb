require 'spec_helper'
require 'health_monitor/providers/resque'

describe HealthMonitor::Providers::Resque do
  subject { described_class.new(request: ActionController::TestRequest.new) }

  describe '#check!' do
    it 'should succesfully check!' do
      expect {
        subject.check!
      }.not_to raise_error
    end

    context 'failing' do
      before do
        Providers.stub_resque_failure
      end

      it 'should fail check!' do
        expect {
          subject.check!
        }.to raise_error(HealthMonitor::Providers::ResqueException)
      end
    end
  end
end
