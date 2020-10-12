import React, { useEffect, useState } from 'react'
import { useDispatch, useSelector, shallowEqual } from 'react-redux'

import { ViewerChannel } from './channels/viewer_channel'
import { ViewerActions } from './store/slices/viewer'
import { ConnectionStatus } from '../shared/components/ConnectionStatus'

const Confirmation = ({ channel }) => {
  const dispatch = useDispatch()
  const confirmed = useSelector((state) => state.viewer.confirmed)

  return (
    <button
      type="button"
      disabled={confirmed}
      className={`btn ${confirmed ? 'btn-default disabled' : 'btn-info'}`}
      onClick={() => {
        if (channel) {
          channel.confirm()
          dispatch(ViewerActions.confirm())
        }
      }}
    >
      CONFIRM
    </button>
  )
}

const ViewerApp = (props) => {
  const dispatch = useDispatch()
  const messages = useSelector((state) => state.viewer.messages, shallowEqual)

  const [channel, setChannel] = useState(null)
  const [connection, setConnectionStatus] = useState(null)

  useEffect(() => {
    console.log('starting channel')
    dispatch(ViewerActions.initiate(window.SESSION))

    const _channel = ViewerChannel({
      log: (...args) => {
        console.log('[ViewerChannel', ...args)
      },

      status(connections) {
        setConnectionStatus(connections)
      },

      connected() {
        setServerConnected(true)
      },

      disconnected() {
        setServerConnected(false)
      },

      message(data) {
        dispatch(ViewerActions.addMessage(data.message))
      },
    })

    setChannel(_channel)

    return () => {
      _channel.disconnect()
      setChannel(null)
    }
  }, [])

  return (
    <div className="row">
      <div className="col">
        <h1 className="text-center">{window.SESSION.token}</h1>
        <div className="messages">
          {messages.length === 0 && (
            <p className="message text-secondary">[NO MESSAGES]</p>
          )}
          {messages.map((message, idx) => {
            return (
              <p className="message" key={idx}>
                {message}
              </p>
            )
          })}
        </div>
        <Confirmation channel={channel} />
      </div>
      <div className="col">
        <ConnectionStatus connection={connection} />
      </div>
    </div>
  )
}

ViewerApp.defaultProps = {}

ViewerApp.propTypes = {}

export default ViewerApp
