// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'
import '../stylesheets/application'

// import RailsUJS from "@rails/ujs"
import Turbolinks from 'turbolinks'

Turbolinks.start()

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'

import store from '../src/viewer/store'

const render = () => {
  const App = require('../src/viewer/ViewerApp').default

  console.log('checkit')
  if (document.getElementById('signin')) {
    console.log('doit')
    ReactDOM.render(
      <Provider store={store}>
        <App />
      </Provider>,
      document.getElementById('signin')
    )
  }
}

const start = () => {
  if (
    document.readyState === 'complete' ||
    (document.readyState !== 'loading' && !document.documentElement.doScroll)
  ) {
    render()
  } else {
    document.addEventListener('DOMContentLoaded', render)
  }
}

start()

if (process.env.NODE_ENV === 'development' && module.hot) {
  module.hot.accept('../src/viewer/store', start)
}
