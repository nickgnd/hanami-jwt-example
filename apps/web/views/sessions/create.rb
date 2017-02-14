module Web::Views::Sessions
  class Create
    include Web::View

     def render
       raw JSON.generate({ auth_token: jwt })
     end
  end
end
