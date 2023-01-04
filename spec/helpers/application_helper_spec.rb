require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_page_title" do
    it "引数が渡されている場合に動的な表示がされているか" do
      expect(full_page_title("sample")).to eq "sample - BIGBAG Store"
    end

    it "引数が空白の場合に動的な表示がされているか" do
      expect(full_page_title("")).to eq "BIGBAG Store"
    end

    it "引数がnilの場合に動的な表示がされているか" do
      expect(full_page_title(nil)).to eq "BIGBAG Store"
    end
  end
end
