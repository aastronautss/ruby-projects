require "./caesar_cipher"

describe "#ceasar_cipher" do
  context "when no shift" do
    it "returns the same string" do
      expect(caesar_cipher("abcd", 0)).to eql "abcd"
    end
  end

  context "when positive shift, middle of the alphabet" do
    it "returns a shifted string" do
      expect(caesar_cipher("lmno", 3)).to eql "opqr"
    end
  end

  context "when positive shift, wraparound" do
    it "returns a shifted string with wraparound" do
      expect(caesar_cipher("wxyz", 2)).to eql "yzab"
    end
  end

  context "when negative shift, middle of the alphabet" do
    it "returns a shifted string" do
      expect(caesar_cipher("lmno", -3)).to eql "ijkl"
    end
  end

  context "when negative shift, wraparound" do
    it "returns a shifted string" do
      expect(caesar_cipher("abcd", -2)).to eql "yzab"
    end
  end

  context "capitals with wraparound" do
    it "returns a shifted string" do
      expect(caesar_cipher("AbCd", -2)).to eql "YzAb"
    end
  end
end
