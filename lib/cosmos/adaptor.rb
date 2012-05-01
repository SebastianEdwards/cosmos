module Cosmos
  class Adaptor
    extend MiddlewareRegistry

    class << self
      attr_accessor :load_error
      private :load_error=
    end

    self.load_error = nil

    def self.associate_media_type(media_type)
      (@associated_media_types ||= []) << media_type
    end

    def self.supports_media_type?(media_type)
      @associated_media_types.select do |associated_media_type|
        return false if self.load_error
        if associated_media_type.is_a? String
          media_type === associated_media_type
        elsif associated_media_type.is_a? Regexp
          media_type.match? associated_media_type
        end
      end.length > 0
    end

    def self.dependency(lib)
      require(lib)
    rescue LoadError, NameError => error
      self.load_error = error
    end

    def self.inherited(subclass)
      super
      (@content_type_classes ||= []) << subclass
    end

    def self.find_by_content_type(content_type)
      return nil if @content_type_classes.nil?
      @content_type_classes.select do |klass|
        klass.supports_media_type?(content_type)
      end.first
    end
  end
end
