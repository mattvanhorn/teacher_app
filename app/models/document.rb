class Document < ApplicationRecord
  belongs_to :folder, optional: true
  has_one_attached :file

  def to_markdown
    return "" unless file.attached?
    markdown(File.read(ActiveStorage::Blob.service.path_for(file.key)))
  end

  private

  # redcarpet markdown
  def markdown(text)
    options = {
        filter_html:     true,
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true,
        fenced_code_blocks: true
    }
    extensions = {
        autolink:           true,
        superscript:        true,
        disable_indented_code_blocks: true
    }

    renderer = ::Redcarpet::Render::HTML.new(options)
    markdown = ::Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
