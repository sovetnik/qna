# methods for controller specs
module ControllerMacros
  def sign_in_user
    before do
      @user = create(:user)
      @user.confirm
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end
end
