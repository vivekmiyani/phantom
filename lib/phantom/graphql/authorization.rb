# frozen_string_literal: true

module Phantom::Graphql::Authorization
  class AuthorizeExtension < GraphQL::Schema::FieldExtension
    def resolve(context:, object:, arguments:, **_rest)
      name, action = options.split("#")

      authorized = name.constantize.new(context[:current_session]).send(action)

      raise GraphQL::ExecutionError, "Unauthorized" unless authorized

      yield object, arguments
    end
  end

  def initialize(*args, authorize: nil, **kwargs, &block)
    extensions = (kwargs[:extensions] ||= [])

    extensions << { Phantom::Graphql::Authorization::AuthorizeExtension => authorize } if authorize.present?

    super(*args, **kwargs, &block)
  end
end
