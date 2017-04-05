class CreateGaasTables < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.string :path, null: false
      t.string :resource_type, null: false
      t.string :build_image_url
      t.string :build_url

      t.datetime :fetched_at
      t.string :fetch_status, null: false
      t.text :fetch_output, null: false
    end

    create_table :gem_infos do |t|
      t.string :name, null: false
      t.string :homepage_url
      t.string :source_code_url
      t.string :documentation_url

      t.timestamps
    end

    create_table :gem_versions do |t|
      t.references :gem_info, foreign_key: true, index: true, null: false
      t.string :version, null: false

      t.timestamps
    end

    create_table :gem_usages do |t|
      t.references :gem_version, foreign_key: true, index: true, null: false
      t.references :resource, foreign_key: true, index: true, null: false
      t.boolean :in_gemfile, null: false, default: false

      t.timestamps
    end

    create_table :vulnerabilities do |t|
      t.string :description, null: false
      t.string :cve
      t.string :url
      t.string :patched_versions
      t.references :gem_version, foreign_key: true, index: true

      t.timestamps
    end
  end
end
