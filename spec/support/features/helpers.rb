module Features
  module Helpers
    def markdown_raw_text
      '*markdown text*'
    end

    def textile_raw_text
      '*textile text*'
    end

    def markdown_text
      '<em>markdown text</em>'
    end

    def textile_text
      '<strong>textile text</strong>'
    end

    def load_default_data(lang = 'en')
      Redmine::DefaultData::Loader.load(lang)
    end

    def create_admin
      password = 'adminpass'
      admin = User.where(login: 'admin').first
      if admin
        admin.password = password
      else
        admin = User.new(firstname: 'Redmine',
                         lastname: 'Admin',
                         mail: 'admin@example.net')
        admin.login = 'admin'
        admin.password = password
        admin.admin = true
      end
      admin.language = 'en'
      admin.save!
    end

    def select_text_for(format)
      Redmine::WikiFormatting.formats_for_select.find { |f| f.last == format }.first
    end
  end
end
