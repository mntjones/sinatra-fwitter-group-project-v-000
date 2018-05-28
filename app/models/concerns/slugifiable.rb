module Slugifiable

  module InstanceMethods
    def slug
      name = self.username.downcase
      name.parameterize
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      name = slug.split("-")
      cap = []

      name.collect do |n|
        cap << n.capitalize
      end

      all.detect { |a| a.slug == slug }
    end
  end

end
