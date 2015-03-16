require 'factory_girl'

module FactoryGirl
  class SeedGenerator
    @ids = {}
    @classes = {}

    def self.create(factory_name, *attributes)
      model = FactoryGirl.create(factory_name, *attributes)
      @ids[factory_name] = model.id
      @classes[factory_name] = model.class

      model
    end

    def self.[](factory_name)
      seed_id = @ids[factory_name]

      if seed_id
        seed_class = @classes[factory_name]
        seed_class.where(seed_class.primary_key => seed_id).first || create(factory_name)
      else
        create(factory_name)
      end
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
