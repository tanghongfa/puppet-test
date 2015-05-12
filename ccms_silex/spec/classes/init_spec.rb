require 'spec_helper'
describe 'ccms_silex' do

  context 'with defaults for all parameters' do
    it { should contain_class('ccms_silex') }
  end
end
