import consumer from './consumer'

export const OperatorChannel = (callbacks) => {
  return consumer.subscriptions.create(
    { channel: 'OperatorChannel' },
    {
      // Called once when the subscription is created.
      initialized() {
        callbacks.log('session initialized as', this.appearingAs)
      },

      // Called when the subscription is ready for use on the server.
      connected() {
        callbacks.log('session connected')
      },

      // Called when the WebSocket connection is closed.
      disconnected() {
        callbacks.log('session disconnected')
      },

      // Called when the subscription is rejected by the server.
      rejected() {
        callbacks.log('operator was rejected')
      },

      received(data) {
        callbacks.log('operator got message', typeof data, JSON.stringify(data))

        if (data.status) {
          callbacks.status(data)
        } else if (data.type) {
          switch (data.type) {
            case 'confirm':
              callbacks.confirm()
              break
            default:
              callbacks.log('unrecognized message type')
          }
        }
      },

      sendMessage(data) {
        this.perform('send_message', data)
      },

      get appearingAs() {
        return window.SESSION ? window.SESSION.id : null
      },
    }
  )
}
