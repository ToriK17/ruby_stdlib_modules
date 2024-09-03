require 'base64'

class Base64Service
  def initialize(data)
    @data = data
  end

  def encode
    Base64.encode64(@data)
  end

  def decode(encoded_data)
    Base64.decode64(encoded_data)
  end

  # Encoding without line breaks
  def strict_encode
    Base64.strict_encode64(@data)
  end

  # Decoding without line breaks
  def strict_decode(encoded_data)
    Base64.strict_decode64(encoded_data)
  end

  # URL-safe encoding, without the characters +, /, and = 
  def urlsafe_encode
    Base64.urlsafe_encode64(@data)
  end

  # URL-safe Decoding
  def urlsafe_decode(encoded_data)
    Base64.urlsafe_decode64(encoded_data)
  end

  # Encoding with custom padding to a different character (default is = without this method)
  def custom_padding_encode(padding_char = '=')
    encoded = Base64.encode64(@data)
    padding = encoded.length % 4 == 0 ? '' : padding_char * (4 - encoded.length % 4)
    encoded.chomp + padding
  end

  # Decoding with custom padding
  def custom_padding_decode(encoded_data, padding_char = '=')
    padded_data = encoded_data + padding_char * ((4 - encoded_data.length % 4) % 4)
    Base64.decode64(padded_data)
  end

  # Encoding binary data, not practical but perhaps useful for obfuscation
  def binary_encode
      # Check if @data is already in binary form
    if @data.is_a?(String) && @data.encoding == Encoding::ASCII_8BIT
      # If data is binary, directly encode with Base64
      Base64.encode64(@data)
    else
      # If data is not binary, first convert it to binary, then encode
      binary_data = @data.unpack('B*').first
      Base64.encode64([binary_data].pack('B*'))
    end
  end

  # Decoding binary data
  def binary_decode(encoded_data)
    binary_data = Base64.decode64(encoded_data).unpack('B*').first
    [binary_data].pack('B*')
  end

  # Custom Base64-like encoding (change built in encoding characters)
  def custom_base64_encode(replacements = {})
    standard = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    custom_encoding = standard.chars.map { |char| replacements[char] || char }.join
    Base64.encode64(@data).tr(standard, custom_encoding)
  end

  # Custom Base64-like decoding (revert built in encoding characters)
  def custom_base64_decode(encoded_data, replacements = {})
    standard = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    custom_encoding = standard.chars.map { |char| replacements[char] || char }.join
    Base64.decode64(encoded_data.tr(custom_encoding, standard))
  end
end
