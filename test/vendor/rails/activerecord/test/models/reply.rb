require 'models/topic'

class Reply < Topic
  named_scope :base

  belongs_to :topic, :foreign_key => "parent_id", :counter_cache => true
  belongs_to :topic_with_primary_key, :class_name => "Topic", :primary_key => "title", :foreign_key => "parent_title", :counter_cache => "replies_count"
  has_many :replies, :class_name => "SillyReply", :dependent => :destroy, :foreign_key => "parent_id"

  validate :errors_on_empty_content
  validate_on_create :title_is_wrong_create

  attr_accessible :title, :author_name, :author_email_address, :written_on, :content, :last_read, :parent_title

  validate :check_empty_title
  validate_on_create :check_content_mismatch
  validate_on_update :check_wrong_update

  def check_empty_title
    errors[:title] << "Empty" unless attribute_present?("title")
  end

  def errors_on_empty_content
    errors[:content] << "Empty" unless attribute_present?("content")
  end

  def check_content_mismatch
    if attribute_present?("title") && attribute_present?("content") && content == "Mismatch"
      errors[:title] << "is Content Mismatch"
    end
  end

  def title_is_wrong_create
    errors[:title] << "is Wrong Create" if attribute_present?("title") && title == "Wrong Create"
  end

  def check_wrong_update
    errors[:title] << "is Wrong Update" if attribute_present?("title") && title == "Wrong Update"
  end
end

class SillyReply < Reply
  belongs_to :reply, :foreign_key => "parent_id", :counter_cache => :replies_count
end

module Web
  class Reply < Web::Topic
    belongs_to :topic, :foreign_key => "parent_id", :counter_cache => true, :class_name => 'Web::Topic'
  end
end