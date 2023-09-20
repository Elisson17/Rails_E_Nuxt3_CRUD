class CreateUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :usuarios do |t|
      t.string :username
      t.string :email
      t.string :senha
      t.string :telefone

      t.timestamps
    end
  end
end
