require 'spec_helper'
describe 'dvn2_linkmanager' do

  context 'with defaults for all parameters' do
    it { should contain_class('dvn2_linkmanager') }
  end
end
