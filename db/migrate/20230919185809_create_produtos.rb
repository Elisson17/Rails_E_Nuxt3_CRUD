class CreateProdutos < ActiveRecord::Migration[7.0]
  def change
    create_table :produtos do |t|
      t.string :titulo
      t.string :preco
      t.string :descri
      t.string :categoria
      t.string :quantidade

      t.timestamps
    end
  end
end
