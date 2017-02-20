module Web::Controllers::Items
  class Index
    include Web::Action

    def call(_)
      items = ItemRepository.new.all
      status 200, JSON.generate(items.map(&:to_h))
    end
  end
end
