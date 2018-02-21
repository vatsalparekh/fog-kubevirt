module Fog
  module Compute
    class Kubevirt
      class Template < Fog::Model
        identity :name,             :aliases => 'metadata_name'

        attribute :namespace,       :aliases => 'metadata_namespace'
        attribute :description,     :aliases => 'metadata_description'
        attribute :tags,            :aliases => 'metadata_tags'
        attribute :labels,          :aliases => 'metadata_labels'
        attribute :resourceVersion, :aliases => 'metadata_resourceVersion'
        attribute :uid,             :aliases => 'metadata_uid'
        attribute :cpu_cores,       :aliases => 'spec_cpu_cores'
        attribute :memory,          :aliases => 'spec_memory'
        attribute :disks,           :aliases => 'spec_disks'
        attribute :volumes,         :aliases => 'spec_volumes'

        def self.parse(object)
          metadata = object[:metadata]
          annotations = metadata[:annotations]
          spec = object[:spec][:template][:spec]
          domain = spec[:domain]
          {
            :namespace       => metadata[:namespace],
            :name            => metadata[:name],
            :description     => annotations[:description],
            :tags            => annotations[:tags],
            :labels          => metadata[:labels],
            :resourceVersion => metadata[:resourceVersion],
            :uid             => metadata[:uid],
            :cpu_cores       => domain[:cpu][:cores],
            :memory          => domain[:resources][:requests][:memory],
            :disks           => domain[:devices][:disks],
            :volumes         => spec[:volumes]
          }
        end
      end
    end
  end
end
