module SnesBuilder
  class AssemblyModule
    def self.name
      raise "name not defined what?!"
    end

    def imports
      []
    end

    def globals
      {}
    end

    def local(label_name)
      "#{self.name}__#{label_name}"
    end

    def exports
      self.class.export_table
    end

    def self.export_table
      @export_table
    end

    def self.def_code(code_name, align = nil, &block)
      module_name = name
      align_val = align
      @export_table ||= []
      @export_table << {
        amod: self,
        name: code_name,
        full_name: "#{module_name}__#{code_name}",
        align: align,
      }
      define_method(code_name) do
        -> do
          align align_val if align_val
          label "#{module_name}__#{code_name}".to_sym
          block_context module_name, code_name
          instance_exec(&block)
        end
      end
    end
  end
end
