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

    def self.def_block(code_name, align = nil, meta = {}, &block)
      module_name = name
      align_val = align
      @export_table ||= []
      @export_table << {
        amod: self,
        name: code_name,
        full_name: "#{module_name}__#{code_name}",
        align: align,
        meta: meta,
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


    def self.def_code(code_name, align = nil, meta = {}, &block)
      def_block(code_name, align, { block_type: :code, code_type: :fragment }.merge(meta), &block)
    end

    def self.def_data(code_name, align = nil, meta = {}, &block)
      def_block(code_name, align, { block_type: :data }.merge(meta), &block)
    end

    def self.def_sub(code_name, align = nil, meta = {}, &block)
      def_block(code_name, align, { block_type: :code, code_type: :sub }.merge(meta)) do
        instance_exec(&block)
        rts
      end
    end

    def self.def_sublong(code_name, align = nil, meta = {}, &block)
      def_block(code_name, align, { block_type: :code, code_type: :sublong }.merge(meta)) do
        instance_exec(&block)
        rtl
      end
    end
  end
end
