module OneboxApiDoc
  class Base

    @tags = []

    def reload_documentation
      rails_mark_classes_for_reload

      api_docs_paths.each do |f|
        load_api_doc_from_file f
      end
      # @checksum = nil if Apipie.configuration.update_checksum

      # locale = old_locale
    end

    def api_docs_paths
      Dir.glob(Rails.root.join(*OneboxApiDoc::Engine.api_docs_matcher.split("/")))
    end

    private

    def load_api_doc_from_file(api_doc_file)
      require api_doc_file
      api_doc_class_name = api_doc_file.gsub(/\A.*\/api_doc\//,"").gsub(/\.\w*\Z/,"").camelize
    end

    # Since Rails 3.2, the classes are reloaded only on file change.
    # We need to reload all the controller classes to rebuild the
    # docs, therefore we just force to reload all the code. This
    # happens only when reload_controllers is set to true and only
    # when showing the documentation.
    #
    # If cache_classes is set to false, it does nothing,
    # as this would break loading of the controllers.
    def rails_mark_classes_for_reload
      unless Rails.application.config.cache_classes
        ActionDispatch::Reloader.cleanup!
        # init_env
        # reload_examples
        ActionDispatch::Reloader.prepare!
      end
    end

  end
end