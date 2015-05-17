require 'spec_helper'
describe 'ccms_drupal' do

  context 'with defaults for all parameters' do
    it { should contain_class('ccms_drupal') }
  end
end
