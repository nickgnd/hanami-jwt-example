module Web::Views::Items
  class Index
    include Web::View

     def render
       raw JSON.generate(items.map(&:to_h))
     end
  end
end
