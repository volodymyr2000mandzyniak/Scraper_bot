# RSpec.describe RezkaPars do
#   before(:each) do
#     @rezka_pars = RezkaPars.new
#   end

#   describe '#login' do
#     it 'should log in successfully with valid credentials' do
#       username = ENV['REZKA_USERNAME']
#       password = ENV['REZKA_PASSWORD']
#       @rezka_pars.login(username, password)
#       expect(page).to have_content('Logged in successfully')
#     end

#     it 'should handle unsuccessful login with invalid credentials' do
#       username = 'invalid_username'
#       password = 'invalid_password'
#       @rezka_pars.login(username, password)
#       expect(page).to have_content('Invalid username or password')
#     end
#   end

# end

RSpec.describe RezkaPars do
  before(:each) do
    @rezka_pars = RezkaPars.new
    @session = Capybara::Session.new(:selenium)
  end

  # describe '#login' do
  #   it 'should log in successfully with valid credentials' do
  #     username = ENV['REZKA_USERNAME']
  #     password = ENV['REZKA_PASSWORD']
  #     @rezka_pars.login(username, password)

  #     # if username == 'expected_username' && password == 'expected_password'
  #     #   expect(@session).to have_content('Welcome, User!')
  #     # else
  #     #   expect(@session).to have_content('Logged in successfully')
  #     # end
  #   end

  #   # it 'should handle unsuccessful login with invalid credentials' do
  #   #   username = 'invalid_username'
  #   #   password = 'invalid_password'
  #   #   @rezka_pars.login(username, password)

  #   #   expect(@session).to have_css('#login-popup-errors li', text: 'Введен неверный логин или пароль.')
  #   # end
  # end

  describe '#add_comment' do
    it 'should add a comment successfully' do
      allow(File).to receive(:readlines).with('data/comments.txt', chomp: true).and_return(['Comment 1', 'Comment 2', 'Comment 3'])
      allow_any_instance_of(Capybara::Node::Element).to receive(:find).and_return(true)
      allow_any_instance_of(Capybara::Node::Element).to receive(:click)
      allow_any_instance_of(Kernel).to receive(:sleep)
      allow_any_instance_of(Capybara::Node::Element).to receive(:execute_script)
      allow_any_instance_of(Capybara::Node::Element).to receive(:click_on)

      @rezka_pars.add_comment

      expect(File).to have_received(:open).with('data/comments.txt', 'a').once do |_, &block|
        expect(block).to be_a(Proc)
        block.call(mock_file)
      end

      expect(mock_file).to have_received(:puts).once
    end
  end




end

