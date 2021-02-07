# frozen_string_literal: true
describe DropboxApi::Client, "#save_url" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the saved file on success", :cassette => "save_url/success_dropbox" do
    result = @client.save_url("/photo_1.jpg", "https://www.dropbox.com/s/834xngq25alcwsi/IMG_8998.JPG?dl=0")

    expect(result.async_job_id).to eq("VofXAX8DO1sAAAAAAAAD_Q")
  end

  it "returns the saved file on success", :cassette => "save_url/success_external" do
    result = @client.save_url("/photo_2.jpg", "https://static1.squarespace.com/static/518aa4bee4b050d373a7e8a2/t/558add71e4b062927077adc6/1435164035794/photo-1427348693976-99e4aca06bb9.jpg")

    expect(result.async_job_id).to eq("VofXAX8DO1sAAAAAAAAD_w")
  end

  it "raises an error with an invalid URL", :cassette => "save_url/invalid_url" do
    expect {
      file = @client.save_url("/photo_3.jpg", "1a6a24061000")
    }.to raise_error(DropboxApi::Errors::InvalidUrlError)
  end
end
