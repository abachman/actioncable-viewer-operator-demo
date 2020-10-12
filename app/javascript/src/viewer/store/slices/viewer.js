import { createSlice } from '@reduxjs/toolkit'

const chat = createSlice({
  name: 'viewer',
  initialState: { messages: [], confirmed: false },
  reducers: {
    initiate(state, action) {
      console.log('init', action)
      const { id, token, active } = action.payload
      state = { id, token, active, messages: [] }
    },

    addMessage(state, action) {
      const message = {
        id: Date.now(),
        content: action.payload,
      }
      state.messages.push(action.payload)
      state.confirmed = false
    },

    confirm(state) {
      state.confirmed = true
    },
  },
})

export const ViewerActions = chat.actions
export default chat.reducer
