# frozen_string_literal: true
describe DropboxApi::Client, "#save_url_check_job_status" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the saved file if job completed", cassette: "save_url_check_job_status/complete" do
    result = @client.save_url_check_job_status "VofXAX8DO1sAAAAAAAAD_Q"

    expect(result).to be_a(DropboxApi::Metadata::File)
  end

  it "returns :in_progress if job not completed", cassette: "save_url_check_job_status/in_progress" do
    save_url_result = @client.save_url("/file.zip", "http://ipv4.download.thinkbroadband.com/1GB.zip")
    status = @client.save_url_check_job_status save_url_result.async_job_id

    expect(status).to eq(:in_progress)
  end

  it "returns a descriptive error if the job failed", cassette: "save_url_check_job_status/failed" do
    save_url_result = @client.save_url("/missing_file.zip", "http://ipv4.download.thinkbroadband.com/not_found.zip")
    # sleep 30 # We may need to wait until job completes to get its failure
    status = @client.save_url_check_job_status save_url_result.async_job_id

    expect(status).to be_a(DropboxApi::Errors::DownloadFailedError)
  end
end
