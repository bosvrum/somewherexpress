# frozen_string_literal: true
ActiveAdmin.register User do
  permit_params :email, :password, :first_name, :last_name, :girl, :picture,
                :admin, :organizer, :old_first_name, :old_last_name, :old_email,
                :provider, :uid, :token, :token_expiry,
                notification_setting_attributes: [:id, :locale,
                                                  :as_user_new_competition,
                                                  :as_user_competition_edited,
                                                  :as_user_new_subscription,
                                                  :as_user_subscription_status_changed,
                                                  :as_author_new_subscription,
                                                  :as_author_cancelation]

  index do
    selectable_column
    column :id
    column "picture" do |user|
      image_tag user.avatar, height: "30px", with: "30px"
    end
    column "gravatar" do |user|
      image_tag user.gravatar_url, height: "30px", with: "30px"
    end
    column :first_name
    column :last_name
    column :email
    column :girl
    column :admin
    column :organizer
    column :uid
    column :sign_in_count
    actions
  end

  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :girl
      f.input :picture
    end
    f.inputs "Admin" do
      f.input :admin
      f.input :organizer
    end
    f.inputs "Deleted" do
      f.input :old_first_name
      f.input :old_last_name
      f.input :old_email
    end
    f.inputs "Facebook" do
      f.input :provider
      f.input :uid
      f.input :token
      f.input :token_expiry
    end

    f.inputs "Notifications", for: [:notification_setting, f.object.notification_setting] do |item|
      item.input :locale, collection: [["English", "en"], ["French", "fr"]]
      item.input :as_user_new_competition
      item.input :as_user_competition_edited
      item.input :as_user_new_subscription
      item.input :as_user_subscription_status_changed
      item.input :as_author_new_subscription
      item.input :as_author_cancelation
    end

    f.actions
  end
end
