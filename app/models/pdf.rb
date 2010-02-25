class Pdf < Asset
  has_attached_file :attachment, 
                    :url => "/admin/pdfs/:id:to_param/download",
                    :path => ":rails_root/assets/products/:id/:style/:basename.:extension"

                    validates_attachment_presence :attachment
                    validates_attachment_size :attachment, :less_than => 50.megabytes
                    validates_attachment_content_type :attachment, :content_type => ['application/pdf']
                    
                    Paperclip::Attachment.interpolations[:to_param] = lambda do |attachment, style|
                      hash = Digest::MD5.hexdigest(attachment.instance.id.to_s + 'secret_word')
                      hash_path = ''
                      3.times { hash_path += '_' + hash.slice!(0..2) }
                      hash_path[1..12]
                    end
                    
end