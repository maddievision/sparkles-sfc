module SnesBuilder
  class AssemblyModule
    def imports
      []
    end

    def self.module_name
      self.name.split("::").last
    end

    def module_name
      self.class.module_name
    end

    def globals
      self.class.globals_table
    end

    def self.globals_table
      @globals_table ||= {}
      @globals_table
    end

    def memory_vars
      self.class.memory_vars
    end

    def self.memory_vars
      @memory_entries ||= []
      @memory_entries
    end

    def register_memory memory_name, addr
      self.class.register_memory memory_name, addr
    end


    def self.register_memory memory_name, addr
      define_singleton_method(memory_name) do
        addr
      end
    end

    def local(label_name)
      "#{self.class.name}__#{label_name}"
    end

    def exports
      self.class.export_table
    end

    def self.export_table
      @export_table ||= []
      @export_table
    end

    def self.equate(equ_name, value)
      @equate_table ||= {}
      @equate_table[equ_name] = value
      define_singleton_method(equ_name) do
        value
      end
    end

    def self.memory(memory_name, size, fixed_addr=nil)
      @memory_entries ||= []
      @memory_entries << [memory_name, size, fixed_addr]
    end

    def self.global_var(var_name, value)
      @globals_table ||= {}
      @globals_table[var_name] = value
    end

    def self.def_block(code_name, align = nil, meta = {}, post_code = nil, &block)
      module_name = self.module_name
      align_val = align
      @export_table ||= []
      @export_table << {
        amod: self,
        name: code_name,
        pre_code: ->(m) do
          align align_val if align_val
          label "#{module_name}__#{code_name}".to_sym
          block_context module_name, code_name
        end,
        code: block,
        post_code: post_code,
        full_name: "#{module_name}__#{code_name}",
        align: align,
        meta: meta,
      }

      # label helper
      define_singleton_method(code_name) do
        "#{module_name}__#{code_name}".to_sym
      end
    end


    def self.def_code(code_name, align = nil, meta = {}, &block)
      def_block(code_name, align, { block_type: :code, code_type: :fragment }.merge(meta), nil, &block)
    end

    def self.def_data(code_name, align = nil, meta = {}, &block)
      def_block(code_name, align, { block_type: :data }.merge(meta), nil, &block)
    end

    def self.def_sub(code_name, align = nil, meta = {}, &block)
      def_block(code_name, align, { block_type: :code, code_type: :sub }.merge(meta), ->(m) do
        rts
      end, &block)
    end

    def self.def_sublong(code_name, align = nil, meta = {}, &block)
      def_block(code_name, align, { block_type: :code, code_type: :sublong }.merge(meta), ->(m) do
        rtl
      end, &block)
    end
  end
end
