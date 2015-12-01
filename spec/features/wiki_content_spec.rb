require_relative '../spec_helper'

feature 'Wiki content', js: true do
  background do
    load_default_data
    sign_in_as_admin
    create_project
  end

  Redmine::WikiFormatting.format_names.each do |format|
    context "when text_formatting setting is #{format}" do
      background do
        Setting.text_formatting = format
      end
      scenario "selected item of select box is #{format} when first visited" do
        visit '/projects/test/wiki'
        expect(format_option('pwfmt-select-content_text', format).selected?).to be_true
      end
      context 'when save as markdown' do
        background do
          visit '/projects/test/wiki'
          select_format('#pwfmt-select-content_text', 'markdown')
          find('#content_text').set markdown_raw_text
          find('input[name=commit]').click
        end
        scenario 'view as markdown' do
          visit '/projects/test/wiki'
          expect(html_by_id('content')).to include markdown_text
        end
        scenario 'selected item of select box is markdown' do
          visit '/projects/test/wiki'
          find("a[accesskey='e']").click
          expect(format_option('pwfmt-select-content_text', 'markdown').selected?).to be_true
        end
        context 'when change format to textile' do
          background do
            visit '/projects/test/wiki'
            find("a[accesskey='e']").click
            select_format('#pwfmt-select-content_text', 'textile')
            find('#content_text').set textile_raw_text
            find('input[name=commit]').click
          end
          scenario 'view as textile' do
            visit '/projects/test/wiki'
            expect(html_by_id('content')).to include textile_text
          end
          scenario 'selected item of select box is textile' do
            visit '/projects/test/wiki'
            find("a[accesskey='e']").click
            expect(format_option('pwfmt-select-content_text', 'textile').selected?).to be_true
          end
          scenario 'view old version as markdown' do
            visit '/projects/test/wiki/Wiki/1'
            expect(html_by_id('content')).to include markdown_text
          end
        end
      end
      context 'when save as textile' do
        background do
          visit '/projects/test/wiki'
          select_format('#pwfmt-select-content_text', 'textile')
          find('#content_text').set textile_raw_text
          find('input[name=commit]').click
        end
        scenario 'view as textile' do
          visit '/projects/test/wiki'
          expect(html_by_id('content')).to include textile_text
        end
        scenario 'selected item of select box is textile' do
          visit '/projects/test/wiki'
          find("a[accesskey='e']").click
          expect(format_option('pwfmt-select-content_text', 'textile').selected?).to be_true
        end
        context 'when change format to markdown' do
          background do
            visit '/projects/test/wiki'
            find("a[accesskey='e']").click
            select_format('#pwfmt-select-content_text', 'markdown')
            find('#content_text').set markdown_raw_text
            find('input[name=commit]').click
          end
          scenario 'view as markdown' do
            visit '/projects/test/wiki'
            expect(html_by_id('content')).to include markdown_text
          end
          scenario 'selected item of select box is markdown' do
            visit '/projects/test/wiki'
            find("a[accesskey='e']").click
            expect(format_option('pwfmt-select-content_text', 'markdown').selected?).to be_true
          end
          scenario 'view old version as textile' do
            visit '/projects/test/wiki/Wiki/1'
            expect(html_by_id('content')).to include textile_text
          end
        end
      end
    end
  end
end
