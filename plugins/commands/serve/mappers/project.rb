module VagrantPlugins
  module CommandServe
    class Mappers
      # Build a project client from a FuncSpec value
      class ProjectFromSpec < Mapper
        def initialize
          inputs = [].tap do |i|
            i << Input.new(type: SDK::FuncSpec::Value) { |arg|
              arg.type == "hashicorp.vagrant.sdk.Args.Project" &&
                !arg&.value&.value.nil?
            }
            i << Input.new(type: Broker)
          end
          super(inputs: inputs, output: Client::Project, func: method(:converter))
        end

        def converter(proto, broker)
          Client::Project.load(proto.value.value, broker: broker)
        end
      end

      # Build a project client from a proto instance
      class ProjectFromProto < Mapper
        def initialize
          inputs = [].tap do |i|
            i << Input.new(type: SDK::Args::Project)
            i << Input.new(type: Broker)
          end
          super(inputs: inputs, output: Client::Project, func: method(:converter))
        end

        def converter(proto, broker)
          Client::Project.load(proto, broker: broker)
        end
      end

      # Build a machine client from a serialized proto string
      class ProjectFromString < Mapper
        def initialize
          inputs = [].tap do |i|
            i << Input.new(type: String)
            i << Input.new(type: Broker)
          end
          super(inputs: inputs, output: Client::Project, func: method(:converter))
        end

        def converter(proto, broker)
          Client::Project.load(proto, broker: broker)
        end
      end
    end
  end
end