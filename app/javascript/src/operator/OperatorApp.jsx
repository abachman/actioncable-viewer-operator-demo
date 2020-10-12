import React, { useEffect, useState, useRef } from 'react'

import { OperatorChannel } from '../viewer/channels/operator_channel'
import { ConnectionStatus } from '../shared/components/ConnectionStatus'

const RemoteControl = ({ channel, confirmed, setConfirmed }) => {
  const input = useRef()
  return (
    <div>
      <form
        className="form-inline"
        onSubmit={(evt) => {
          evt.preventDefault()
          channel.sendMessage({ message: input.current.value })
          setConfirmed(false)
          input.current.value = ''
        }}
      >
        <div className="form-group mb-2">
          <label className="sr-only">Message</label>
          <input
            ref={input}
            type="text"
            className="form-control"
            placeholder="Message"
          />
        </div>
        <button type="submit" className="btn btn-primary mb-2">
          SEND
        </button>
        <span style={{ marginLeft: '12px' }}>
          {confirmed ? <strong>CONFIRMED</strong> : 'UNCONFIRMED'}
        </span>
      </form>
    </div>
  )
}

const OperatorApp = () => {
  const [connection, setConnectionStatus] = useState(null)
  const [channel, setChannel] = useState(null)
  const [confirmed, setConfirmed] = useState(false)

  useEffect(() => {
    const _channel = OperatorChannel({
      log(...args) {
        console.log('[OperatorChannel]', ...args)
      },

      status(connections) {
        console.log('set status', connections)
        setConnectionStatus(connections)
      },

      confirm() {
        setConfirmed(true)
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
        {connection?.status?.viewer ? (
          <RemoteControl
            channel={channel}
            confirmed={confirmed}
            setConfirmed={setConfirmed}
          />
        ) : (
          <p>No viewers are connected</p>
        )}
      </div>

      <div className="col">
        <ConnectionStatus connection={connection} />
      </div>
    </div>
  )
}

export default OperatorApp
