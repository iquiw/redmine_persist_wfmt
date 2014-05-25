module Features
  module Helpers
    def raw_text
      '*foobarbaz*'
    end

    def markdown_text
      '<em>foobarbaz</em>'
    end

    def textile_text
      '<strong>foobarbaz</strong>'
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
      admin.save!
    end

    def html_by_id(id)
      page.evaluate_script("document.getElementById('#{id}').innerHTML")
    end

    def select_text_for(format)
      Redmine::WikiFormatting.formats_for_select.find { |f| f.last == format }.first
    end

    def format_option(select_box_id, format)
      find("##{select_box_id}").find("option[value=#{format}]")
    end
  end
end
