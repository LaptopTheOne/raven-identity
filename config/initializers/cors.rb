Rails.application.config.middleware.insert_before 0, ::Rack::Cors do
  allow do
    if !Rails.env.production?
      origins 'localhost:8080'
    else
      origins 'https://raven-skeleton.netlify.app'
    end

    resource('*', headers: :any, methods: %i[get options post put delete])
  end

  # allow do
  #   origins 'https://stripe.com/docs/webhooks'
  #   resource('*', headers: :any, methods: %i[post])
  # end

  # allow do
  #   origins '*'
  #   resource('*', headers: :any, methods: %i[get options])
  # end
end
