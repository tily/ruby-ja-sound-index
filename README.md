# Ja::SoundIndex

## 概要
日本語カタカナから母音・子音によるインデックスを作成するライブラリ。

## 使い方
 * example/test.rb

        require 'ja/sound_index'
        
        katakana = 'オンドゥルルラギッタンディスカー'
        
        idx = Ja::SoundIndex.new(:ascii)
        
        puts idx.vowel(katakana)               # OUUUAIAIUA
        puts idx.consonant(katakana)           # ADRRRGTDSK
        
        puts idx.vowel(katakana, ['ー'])       # OUUUAIAIUA-
        puts idx.consonant(katakana, ['ッ'])   # ADRRRG.TDSK
        
        idx2 = Ja::SoundIndex.new(:utf_8)
        
        puts idx2.vowel(katakana)              # オウウウアイアイウア
        puts idx2.consonant(katakana)          # アダラララガタダサカ
        
        puts idx2.vowel(katakana, ['ー'])      # オウウウアイアイウアー
        puts idx2.consonant(katakana, ['ッ'])  # アダラララガッタダサカ
