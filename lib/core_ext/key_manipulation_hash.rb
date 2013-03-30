
# key_manipulation_hash.rb
#
# Additional hash functions for hash key conversion operations
#
# Copyright Adrian S. Kierman 2013

# Uses similar process as rails does to add functionality to the hash
# class (by reopening the hash class and adding new methods)

class Hash
  # Returns this hash with all the keys made lower case.
  # This will iterate through nested hashes and nested arrays as well.
  def keys_to_downcase()
    self.deep_convert_keys { |k| k.to_s.downcase }
  end

  # Returns this hash with all the keys made into ruby symbols.
  # This will iterate through nested hashes and nested arrays as well.
  def keys_to_symbols()
    self.deep_convert_keys { |k| k.to_s.to_sym }
  end

  # Descends through a nested hash and converts just the keys of the hash using a supplied block.
  # Nested arrays and nested hashes are also processed.
  # Params:
  # +key_conversion_block+:: a block of code that will convert a key and return a new key.
  def deep_convert_keys(&key_conversion_block)
    if (block_given?)
      result={}
      self.each_pair do |k, v|
        case v
          when String, Fixnum then
            result[yield(k)]=v
          when Hash then
            result[yield(k)]=v.deep_convert_keys(&key_conversion_block)
          when Array then
            result[yield(k)]=v.collect { |a| a.deep_convert_keys(&key_conversion_block)  }
          when NilClass then
            result[yield(k)]="NIL"
          else
            raise ArgumentError, "Unhandled type #{v.class}"
        end
      end
     return result
    end
    return self # return self if no key conversion block was given to this method
  end
end