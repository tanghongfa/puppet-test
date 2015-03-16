require 'spec_helper'
describe 'runpatch' do

  context 'with defaults for all parameters' do
    it { should contain_class('runpatch') }
  end
end
