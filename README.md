# Phantom

## Graphql

### Shorthand

- Includes `enum` shorthand,

  ```rb
  field :status, enum("PersonStatusEnum", Person.statuses.keys), null: false
  ```

### Response handler

- Catches errors automatically:

  - `ActiveRecord::RecordNotFound`

- Includes `raise_error` response handler in `GraphQL::Schema::RelayClassicMutation`

  ```rb
  raise_error person.errors.full_messages.to_sentence unless person.update(status: :active)
  ```

### Authorization

- Add `authorize` option to `field`

  ```rb
  # app/graphql/types/base_field.rb

  field_class.include(Phantom::Graphql::FieldExtensions)
  ```

  ```rb
  field :posts, [Types::PostType], authorize: "PostPolicy#index?", null: false
  ```

### Preload to prevent N+1

- Pass asscoation name in `preload` which will fix N+1 query
- Pass Policy name in `scope`, which will reduces scope in preloaded query

  ```rb
  class Types::PostType < Types::BaseObject
    field :comments, [Types::CommentType], scope: "CommentPolicy", preload: :comments, null: false
  end
  ```
