module Aggregate
  def self.included(cls)
    cls.class_exec do
      include Schema::DataStructure
      include Messaging::StreamName
      include EntityProjection

      extend Build
      extend Handle

      dependency :write, Messaging::Write

      def initialize
      end
    end
  end

  module Build
    def build
      instance = new
      instance.configure
      instance
    end
  end

  module Handle
    def handle(message_type, &block)
      apply_macro(message_type, &block)
    end
  end
end
