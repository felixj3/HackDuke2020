require 'net/http'
require 'json'

class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    # deactivative CSRF token authenticity

    def contact_python(dict = {})
        uri = URI('http://localhost:' + $BACKBACKENDPORT.to_s)
        res = Net::HTTP.post_form(uri, 'data' => dict.to_json)
        return JSON.parse(res.body)
    end

    def getCurrentUser
        return User.find_by(id: current_user.id)
    end
end
