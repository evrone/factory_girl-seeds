require 'factory_girl'

module FactoryGirl
  class SeedGenerator
    @ids = {}
    @classes = {}

    def self.create(factory_name, *attributes)
      model = FactoryGirl.create(factory_name, *attributes)
      @ids[factory_name.to_s + attributes.to_s] = model.id
      @classes[factory_name] = model.class

      model
    end

    def self.[](factory_name, *attributes)
      seed_id = @ids[factory_name.to_s + attributes.to_s]

      if seed_id
        seed_class = @classes[factory_name]
        seed_class.where(seed_class.primary_key => seed_id).first ||
          create(factory_name, *attributes)
      else
        create(factory_name, *attributes)
      end
    end
  end
end

module FactoryGirl
  module Syntax
    module SeedMethods
      def seed(factory_name, *attributes)
        if defined?(Rails) && !Rails.env.test?
          FactoryGirl.create(factory_name, *attributes)
        else
          FactoryGirl::SeedGenerator[factory_name, *attributes]
        end
      end
    end
  end
end

FactoryGirl::Syntax::Methods.send(:include, FactoryGirl::Syntax::SeedMethods)
FactoryGirl::SyntaxRunner.send(:include, FactoryGirl::Syntax::SeedMethods)
FactoryGirl.send(:extend, FactoryGirl::Syntax::SeedMethods)
