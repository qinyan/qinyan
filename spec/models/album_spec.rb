require 'spec_helper'

describe Album do

  describe 'validations name' do
    context 'name reject nil, name size maximum 20' do
      it { should_not accept_values_for(:name, nil, 'a'*21) }
    end
  end

  describe 'validations user_id' do
    context 'user_id reject nil' do
      it { should_not accept_values_for(:user_id, nil)}
    end
  end

end
