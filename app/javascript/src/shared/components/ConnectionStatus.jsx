import React from 'react'
import PropType from 'prop-types'

const ConnectionStatus = ({ connection }) => {
  console.log('ConnectionStatus with', connection)
  const { status, identity } = connection || {}
  return (
    <div className="connection-status">
      <h3>CONNECTION STATUS</h3>
      <p>
        <strong className="text-primary">✅</strong> Server
      </p>
      <p>
        {status?.operator ? (
          <strong className="text-primary">✅</strong>
        ) : (
          <strong className="text-danger">❌</strong>
        )}{' '}
        Operator
      </p>
      <p>
        {status?.viewer ? (
          <strong className="text-primary">✅</strong>
        ) : (
          <strong className="text-danger">❌</strong>
        )}{' '}
        Viewer
      </p>
    </div>
  )
}

ConnectionStatus.propTypes = {
  connection: PropType.shape({
    status: PropType.shape({
      viewer: PropType.bool,
      operator: PropType.bool,
    }),
    identity: PropType.shape({
      viewer: PropType.string,
      operator: PropType.string,
    }),
  }),
}

ConnectionStatus.defaultProps = {
  connection: {
    status: {
      viewer: false,
      operator: false,
    },
  },
}

export { ConnectionStatus }
