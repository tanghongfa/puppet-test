require 'spec_helper'
describe 'mco_plugins' do

  context 'with defaults for all parameters' do
    it { should contain_class('mco_plugins') }
  end
end
