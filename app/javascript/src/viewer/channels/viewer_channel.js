import consumer from './consumer'

export const ViewerChannel = (callbacks) => {
  return consumer.subscriptions.create(
    { channel: 'ViewerChannel' },
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
        callbacks.log('viewer was rejected')
      },

      received(data) {
        callbacks.log('viewer got message', typeof data, JSON.stringify(data))

        if (data.status) {
          callbacks.status(data)
        } else if (data.type) {
          switch (data.type) {
            case 'message':
              callbacks.message(data.payload)
          }
        }
      },

      confirm() {
        this.perform('confirm')
      },

      get appearingAs() {
        return window.SESSION ? window.SESSION.id : null
      },
    }
  )
}
