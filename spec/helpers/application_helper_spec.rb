require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_page_title" do
    context "page_titleが存在する場合" do
      it "動的なタイトルになること" do
        expect(full_page_title("sample")).to eq "sample - BIGBAG Store"
      end
    end

    context "page_titleが空白の場合" do
      it "動的なタイトルになること" do
        expect(full_page_title("")).to eq "BIGBAG Store"
      end
    end

    context "page_titleが存在しない場合" do
      it "動的なタイトルになること" do
        expect(full_page_title(nil)).to eq "BIGBAG Store"
      end
    end
  end
end
