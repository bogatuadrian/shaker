require 'songs'

class Song
  attr_reader :title, :artist, :album, :playcount, :num

  @@songs = []

  def initialize(song)

    @num = get_available_num
    @num = song["num"].to_i unless song["num"] == nil

    @title = song["title"]
    @artist = song["artist"]
    @album = song["album"]
    @playcount = song["playcount"].to_i

  end

  def save
    @@songs = @@songs.select do |song|
      song.num != self.num
    end
    @@songs << self
  end

  def self.find_by_num(num)
    @@songs.find do |song|
      song.num == num
    end
  end

  def self.find_by_artist(artist)
    @@songs.select do |song|
      song.artist == artist
    end
  end

  def self.find_by_artist_and_title(artist, title)
    self.find_by_artist(artist).find do |song|
      song.title == title
    end
  end

  def self.load_from_hash_array(hash_array)
    hash_array.each do |song|
      self.new(song).save
    end
  end

  def self.top_played(n = 999)
    @@songs.sort { |s1, s2| s2.playcount <=> s1.playcount }.take(n)
  end

  def self.all
    @@songs
  end

  def self.delete_all
    @@songs = []
    @@num = 0
  end


  private
    # finds the first unused num
    def get_available_num
      num = 1
      while @@songs.find { |s| s.num == num } do
        num += 1
      end

      num
    end
end
