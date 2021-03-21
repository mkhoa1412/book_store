module ControllerMacros
  def login_account(&proc)
    before(:each) do
      # @request.env['devise.mapping'] = Devise.mappings[:account]
      @account = proc ? instance_eval(&proc) : create(:account)
      sign_in @account
    end
  end
end
