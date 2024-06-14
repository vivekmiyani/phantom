# frozen_string_literal: true

module Phantom::Graphql::FieldExtensions
  class AuthorizeExtension < GraphQL::Schema::FieldExtension
    def resolve(context:, object:, arguments:, **_rest)
      name, action = options.split("#")

      authorized = name.constantize.new(context[:current_session]).send(action)

      raise GraphQL::ExecutionError, "Unauthorized" unless authorized

      yield object, arguments
    end
  end

  class PreloadExtension < GraphQL::Schema::FieldExtension
    def resolve(context:, object:, arguments:, **rest)
      BatchLoader::GraphQL.for(object).batch(key: field) do |records, loader|
        scope = options[:scope].constantize.new(context[:current_session]).scope if options[:scope].present?
        ActiveRecord::Associations::Preloader.new(records: records.map(&:object), associations: options[:preload]).call
        records.each { |r| loader.call(r, super(context: context, object: r, arguments: arguments, **rest)) }
      end
    end
  end

  def initialize(*args, authorize: nil, preload: nil, scope: nil, **kwargs, &block)
    extensions = (kwargs[:extensions] ||= [])

    extensions << { Phantom::Graphql::FieldExtensions::AuthorizeExtension => authorize } if authorize.present?
    extensions << { Phantom::Graphql::FieldExtensions::PreloadExtension => { preload: preload, scope: scope } } if preload.present?

    super(*args, **kwargs, &block)
  end
end
