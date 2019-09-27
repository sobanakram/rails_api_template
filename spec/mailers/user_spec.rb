require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "send_reset_password_code" do
    let(:mail) { UserMailer.send_reset_password_code }

    it "renders the headers" do
      expect(mail.subject).to eq("Send reset password code")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
