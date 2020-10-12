import 'bootstrap'
import '../stylesheets/operator.scss'

import React from 'react'
import ReactDOM from 'react-dom'

const render = () => {
  if (document.getElementById('operator-app')) {
    const ConnectionStatus = require('../src/operator/OperatorApp').default

    ReactDOM.render(
      <ConnectionStatus />,
      document.getElementById('operator-app')
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
