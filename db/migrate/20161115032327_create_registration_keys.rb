class CreateRegistrationKeys < ActiveRecord::Migration[5.0]
    def change
        create_table :registration_keys do |t|
            t.string :key

            t.timestamps
        end
        add_index('registration_keys', 'key', unique: true)
    end
end
