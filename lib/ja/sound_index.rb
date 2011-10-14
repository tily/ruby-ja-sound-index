# -*- coding:utf-8 -*-
class Ja
  class SoundIndex
    VOWEL     = %w[A I U E O]
    CONSONANT = %w[A K S T N H M Y R W G Z D B P]
    LARGE = [
      'ア', 'イ', 'ウ', 'エ', 'オ', 'カ', 'キ', 'ク', 'ケ', 'コ', 
      'サ', 'シ', 'ス', 'セ', 'ソ', 'タ', 'チ', 'ツ', 'テ', 'ト', 
      'ナ', 'ニ', 'ヌ', 'ネ', 'ノ', 'ハ', 'ヒ', 'フ', 'ヘ', 'ホ', 
      'マ', 'ミ', 'ム', 'メ', 'モ', 'ヤ',  nil, 'ユ',  nil, 'ヨ', 
      'ラ', 'リ', 'ル', 'レ', 'ロ', 'ワ', 'ヰ', 'ヴ', 'ヱ', 'ヲ', 
      'ガ', 'ギ', 'グ', 'ゲ', 'ゴ', 'ザ', 'ジ', 'ズ', 'ゼ', 'ゾ', 
      'ダ', 'ヂ', 'ヅ', 'デ', 'ド', 'バ', 'ビ', 'ブ', 'ベ', 'ボ', 
      'パ', 'ピ', 'プ', 'ペ', 'ポ',
    ]
    SMALL = [
      'ァ',  'ィ', 'ゥ', 'ェ', 'ォ', 'ャ',   nil, 'ュ',  nil, 'ョ',
      'ヮ'
    ]
    SPECIAL = {'ッ' => '.', 'ー' => '-', 'ン' => 'N'}

    def initialize(mode)
      @mode = mode
    end
  
    def only_katakana?(text)
      text.match /^[#{LARGE.join}#{SMALL.join}#{SPECIAL.keys.join}]+$/u
    end
  
    def vowel(text, with=[])
      if !only_katakana?(text)
        raise ArgumentError, 'Error: first param must consist only of katakana.'
      end
      text = text.gsub(/([#{LARGE.join}])([#{SMALL.join}])*/u) {
        map, snd = $2 ? [SMALL, $2] : [LARGE, $1]
	arr = @mode == :ascii ? VOWEL : LARGE
        arr[map.index(snd) % 5]
      }
      special(text, with)
    end

    def consonant(text, with=[])
      if !only_katakana?(text)
        raise ArgumentError, 'Error: first param must consist only of katakana.'
      end
      text = text.gsub(/([#{LARGE.join}])/u) {
        i = LARGE.index($1) - LARGE.index($1) % 5
        @mode == :ascii ? CONSONANT[i / 5] : LARGE[i]
      }
      text = text.gsub(/[#{SMALL.join}]/u, '')
      special(text, with)
    end

    private
    def special(text, with)
      if !(without = SPECIAL.keys - with).empty?
        text = text.gsub(/[#{without.join}]/u, '')
      end
      if @mode == :ascii
        SPECIAL.each do |k, v|
	  text = text.gsub(/#{k}/u) { v }
        end
      end
      text
    end
  end
end

if __FILE__ == $0
  puts k = STDIN.read.chomp
  [:ascii, :utf_8].each do |mode|
  	jsi = Ja::SoundIndex.new(mode)
	[[], ['ー', 'ン', 'ッ']].each do |with|
  		puts jsi.vowel(k, with)
  		puts jsi.consonant(k, with)
	end
  end
end
