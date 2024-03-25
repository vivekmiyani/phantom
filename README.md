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

  field_class.include(Phantom::Graphql::Authorization)
  ```

  ```rb
  field :posts, [Types::PostType], authorize: "PostPolicy#index?", null: false
  ```
