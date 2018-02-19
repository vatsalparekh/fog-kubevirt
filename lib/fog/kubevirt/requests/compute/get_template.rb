module Fog
  module Compute
    class Kubevirt
      class Real
        def get_template(name)
          to_hash client.get_template(name, 'default')
        end
      end

      class Mock
        def get_template(name)
        end
      end
    end
  end
end
