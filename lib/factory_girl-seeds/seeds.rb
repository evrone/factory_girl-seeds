require 'factory_girl'

module FactoryGirl
  class SeedGenerator
    @primary_keys = {}

    def self.create(factory_name, *attributes)
      model = FactoryGirl.create(factory_name, *attributes)
      @primary_keys[factory_name] = model[model.class.primary_key]

      model
    end

    def self.[](factory_name)
      klass = factory_name.to_s.classify.constantize
      seed_id = @primary_keys[factory_name]
      seed_id && klass.find_by(klass.primary_key => seed_id) || create(factory_name)
    end
  end
end

module FactoryGirl
  module Syntax
    module SeedMethods
      def seed(factory_name)
        if defined?(Rails) && !Rails.env.test?
          FactoryGirl.create(factory_name)
        else
          FactoryGirl::SeedGenerator[factory_name]
        end
      end
    end
  end
end

FactoryGirl::Syntax::Methods.send(:include, FactoryGirl::Syntax::SeedMethods)
FactoryGirl::SyntaxRunner.send(:include, FactoryGirl::Syntax::SeedMethods)
FactoryGirl.send(:extend, FactoryGirl::Syntax::SeedMethods)
